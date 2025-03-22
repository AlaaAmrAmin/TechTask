import Foundation

protocol RecipesUseCaseType {
    func fetchRecipes(withTags tags: [String], startingFrom itemNumber: Int) async throws -> Recipes
    func fetchRecipe(with id: String) async throws -> Recipe
}

struct RecipesUseCase: RecipesUseCaseType {
    private let repository: any RecipesRemoteLoader
    private let recipesResponseMapper: any ResponseDomainMapping<RecipesDTO, Recipes>
    private let recipeResponseMapper: any ResponseDomainMapping<RecipeDTO, Recipe>
    
    init(
        repository: any RecipesRemoteLoader,
        recipesResponseMapper: any ResponseDomainMapping<RecipesDTO, Recipes>,
        recipeResponseMapper: any ResponseDomainMapping<RecipeDTO, Recipe>
    ) {
        self.repository = repository
        self.recipesResponseMapper = recipesResponseMapper
        self.recipeResponseMapper = recipeResponseMapper
    }
    
    func fetchRecipes(withTags tags: [String], startingFrom itemNumber: Int) async throws -> Recipes {
        let recipesDTO = try await repository.fetchRecipes(withTags: tags, startingFrom: itemNumber)
        return recipesResponseMapper.map(recipesDTO)
    }
    
    func fetchRecipe(with id: String) async throws -> Recipe {
        let recipeDTO = try await repository.fetchRecipe(with: id)
        return recipeResponseMapper.map(recipeDTO)
    }
}

