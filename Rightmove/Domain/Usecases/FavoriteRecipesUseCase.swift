//import Foundation
//
//protocol FavouriteRecipeInput {
//    func favourite(withTags tags: [String]) async throws -> [Recipes.RecipeOverview]
//    func fetchMoreRecipes(withTags tags: [String]) async throws -> [Recipes.RecipeOverview]
//    func fetchRecipe(with id: String) async throws -> Recipe
//}
//
//class RecipesUseCase: RecipesInput {
//    private var recipes: [Recipes.RecipeOverview] = []
//    private var totalNumberOfRecipes = 0
//    private let repository: any RecipesRemoteLoader
//    private let recipesResponseMapper: any ResponseDomainMapping<RecipesDTO, Recipes>
//    private let recipeResponseMapper: any ResponseDomainMapping<RecipeDTO, Recipe>
//    
//    init(
//        repository: some RecipesRemoteLoader,
//        recipesResponseMapper: some ResponseDomainMapping<RecipesDTO, Recipes>,
//        recipeResponseMapper: some ResponseDomainMapping<RecipeDTO, Recipe>
//    ) {
//        self.repository = repository
//        self.recipesResponseMapper = recipesResponseMapper
//        self.recipeResponseMapper = recipeResponseMapper
//    }
//    
//    func fetchRecipes(withTags tags: [String]) async throws -> [Recipes.RecipeOverview] {
//        let recipes = try await fetchRecipes(withTags: tags, startingFrom: 0)
//        self.recipes = recipes.list
//        self.totalNumberOfRecipes = recipes.totalNumberOfRecipes
//        return self.recipes
//    }
//    
//    func fetchMoreRecipes(withTags tags: [String]) async throws -> [Recipes.RecipeOverview] {
//        guard recipes.count < totalNumberOfRecipes  else {
//            return []
//        }
//        
//        let recipes = try await fetchRecipes(withTags: tags, startingFrom: recipes.count - 1)
//        self.recipes.append(contentsOf: recipes.list)
//        return recipes.list
//    }
//    
//    func fetchRecipe(with id: String) async throws -> Recipe {
//        let recipeDTO = try await repository.fetchRecipe(with: id)
//        return recipeResponseMapper.map(recipeDTO)
//    }
//    
//    private func fetchRecipes(withTags tags: [String], startingFrom itemNumber: Int) async throws -> Recipes {
//        let recipesDTO = try await repository.fetchRecipes(withTags: tags, startingFrom: itemNumber)
//        return recipesResponseMapper.map(recipesDTO)
//    }
//}
//
