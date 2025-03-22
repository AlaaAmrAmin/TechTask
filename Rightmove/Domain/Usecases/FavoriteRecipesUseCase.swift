import Foundation

protocol FavoriteRecipesInput: Sendable {
    func fetchFavorites() async throws -> [Recipes.RecipeOverview]
    func favorite(_ recipe: Recipes.RecipeOverview) async throws
    func unfavorite(_ recipe: Recipes.RecipeOverview) async throws
}

struct FavoriteRecipesUseCase: FavoriteRecipesInput {
    private let repository: any RecipesLocalLoader
    private let recipesMapper: any RecipesEntityMapping
    private let recipeMapper: any RecipeEntityMapping
    
    init(
        repository: some RecipesLocalLoader,
        recipesMapper: some RecipesEntityMapping,
        recipeMapper: some RecipeEntityMapping
    ) {
        self.repository = repository
        self.recipesMapper = recipesMapper
        self.recipeMapper = recipeMapper
    }
    
    func fetchFavorites() async throws -> [Recipes.RecipeOverview] {
        let recipeEntities = try await repository.fetchRecipes()
        return recipesMapper.map(recipeEntities).list
    }
    
    func favorite(_ recipe: Recipes.RecipeOverview) async throws {
        let entity = recipeMapper.map(recipe)
        return try await repository.store(entity)
    }
    
    func unfavorite(_ recipe: Recipes.RecipeOverview) async throws {
        let entity = recipeMapper.map(recipe)
        return try await repository.delete(entity)
    }
}

