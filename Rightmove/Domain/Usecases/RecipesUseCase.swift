import Foundation

protocol RecipesInput: Sendable {
    func fetchRecipes() async throws -> [Recipes.RecipeOverview]
    func fetchMoreRecipes() async throws -> [Recipes.RecipeOverview]
    func fetchRecipe(with id: Int) async throws -> Recipe
}

actor RecipesUseCase: RecipesInput {
    private let favoritesUseCase: FavoriteRecipesInput
    
    private let repository: any RecipesRemoteLoader
    private let recipesResponseMapper: any ResponseDomainMapping<RecipesDTO, Recipes>
    private let recipeResponseMapper: any ResponseDomainMapping<RecipeDTO, Recipe>
    
    private var recipesCache: Recipes = Recipes(list: [], totalNumberOfRecipes: 0)
    private var fetchingRecipesState: FetchingRecipesState = .notStarted
    private var fetchingMoreRecipesState: FetchingMoreRecipesState = .notStarted
    
    init(
        favoritesUseCase: some FavoriteRecipesInput,
        remoteRepository: some RecipesRemoteLoader,
        recipesResponseMapper: some ResponseDomainMapping<RecipesDTO, Recipes>,
        recipeResponseMapper: some ResponseDomainMapping<RecipeDTO, Recipe>
    ) {
        self.favoritesUseCase = favoritesUseCase
        self.repository = remoteRepository
        self.recipesResponseMapper = recipesResponseMapper
        self.recipeResponseMapper = recipeResponseMapper
    }
}

// MARK: - Fetch Recipes

extension RecipesUseCase {
    func fetchRecipes() async throws -> [Recipes.RecipeOverview] {
        if case let .ongoing(task) = fetchingRecipesState {
            task.cancel()
        }
        
        let task = Task {
            let favoriteRecipes = try? await favoritesUseCase.fetchFavorites()
            let recipes = try await fetchRecipes(withTags: [], startingFrom: 0)
            if let favoriteRecipes {
                var list = recipes.list
                markFavoriteRecipes(in: &list, using: favoriteRecipes)
                return Recipes(list: list, totalNumberOfRecipes: recipes.totalNumberOfRecipes)
            } else {
                return recipes
            }
        }
        
        fetchingRecipesState = .ongoing(task)
        let recipes = try await task.value
        recipesCache = Recipes(list: recipes.list, totalNumberOfRecipes: recipes.totalNumberOfRecipes)
        fetchingRecipesState = .completed
        
        return recipes.list
    }
    
    func fetchMoreRecipes() async throws -> [Recipes.RecipeOverview] {
        if case let .ongoing(task) = fetchingMoreRecipesState {
            return try await task.value
        }
        
        guard recipesCache.list.count < recipesCache.totalNumberOfRecipes  else {
            return []
        }
        
        let task = Task {
            var recipes = try await fetchRecipes(withTags: [], startingFrom: recipesCache.list.count - 1).list
            if let favoriteRecipes = try? await favoritesUseCase.fetchFavorites() {
                markFavoriteRecipes(in: &recipes, using: favoriteRecipes)
            }
            return recipes
        }
        
        fetchingMoreRecipesState = .ongoing(task)
        let newRecipes = try await task.value
        recipesCache.list.append(contentsOf: newRecipes)
        fetchingMoreRecipesState = .completed
        
        return newRecipes
    }
    
    private func fetchRecipes(withTags tags: [String], startingFrom itemNumber: Int) async throws -> Recipes {
        let recipesDTO = try await repository.fetchRecipes(withTags: tags, startingFrom: itemNumber)
        try Task.checkCancellation()
        return recipesResponseMapper.map(recipesDTO)
    }
    
    private func markFavoriteRecipes(
        in list: inout [Recipes.RecipeOverview],
        using favorites: [Recipes.RecipeOverview]
    ) {
        for i in 0 ..< list.count {
            if favorites.contains(list[i]) {
                list[i].isFavorite = true
            }
        }
    }
}

// MARK: - Fetch Recipe Details

extension RecipesUseCase {
    nonisolated func fetchRecipe(with id: Int) async throws -> Recipe {
        let recipeDTO = try await repository.fetchRecipe(with: String(id))
        let favoriteRecipes = try? await favoritesUseCase.fetchFavorites()
        var recipe = recipeResponseMapper.map(recipeDTO)
        recipe.isFavorite = favoriteRecipes?.contains(where: { $0.id == recipe.id }) ?? false
        return recipe
    }
}

extension RecipesUseCase {
    enum FetchingRecipesState {
        case notStarted
        case ongoing(Task<Recipes, Error>)
        case completed
    }
    
    enum FetchingMoreRecipesState {
        case notStarted
        case ongoing(Task<[Recipes.RecipeOverview], Error>)
        case completed
    }
}

