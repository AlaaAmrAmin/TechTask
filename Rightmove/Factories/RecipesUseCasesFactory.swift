struct RecipesUseCasesFactory {
    static func makeRecipesUseCase() -> RecipesUseCase {
        // APIClient
        let apiClient = APIClient()
        
        // Request Constructor
        let requestConstructor = RequestConstructor(
            baseURL: TastyAPIConfig.baseURLString
        )
        
        // Remote Repository
        let remoteRepository = RecipesRemoteRepository(
            requestConstructor: requestConstructor,
            client: apiClient,
            pageSize: 20
        )

        // Mappers
        let recipesResponseMapper = RecipesResponseMapper(
            ratingMapper: RecipeRatingResponseMapper(),
            timeMapper: TimeResponseMapper()
        )
        
        let recipeResponseMapper = RecipeResponseMapper(
            ratingMapper: RecipeRatingResponseMapper(),
            timeMapper: TimeResponseMapper(),
            instructionsMapper: InstructionsResponseMapper(),
            ingredientsMapper: IngredientsResponseMapper(),
            nutritionMapper: NutritionResponseMapper()
        )
        
        let favoritesUseCase = makeFavoriteRecipesUseCase()
        
        return RecipesUseCase(
            favoritesUseCase: favoritesUseCase,
            remoteRepository: remoteRepository,
            recipesResponseMapper: recipesResponseMapper,
            recipeResponseMapper: recipeResponseMapper
        )
    }
    
    static func makeFavoriteRecipesUseCase() -> FavoriteRecipesUseCase {
        // Local Repository
        let jsonFileClient = JSONFileClient<[RecipeEntity]>(
            fileName: "favorites.json",
            fileManager: .default
        )
        let localRepository = RecipesLocalRepository(client: jsonFileClient)
        
        // Mappers
        let recipesEntityMapper = RecipesEntityMapper()
        let recipeEntityMapper = RecipeEntityMapper()
        
        return FavoriteRecipesUseCase(
            repository: localRepository,
            recipesMapper: recipesEntityMapper,
            recipeMapper: recipeEntityMapper
        )
    }
}