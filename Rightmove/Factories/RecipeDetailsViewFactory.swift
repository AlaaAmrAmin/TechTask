@MainActor
struct RecipeDetailsViewFactory {
    static func makeView(for recipeID: Int) -> RecipeDetailsHostView {
        let recipesUseCase = RecipesUseCasesFactory.makeRecipesUseCase()
        let favoritesUseCase = RecipesUseCasesFactory.makeFavoriteRecipesUseCase()
        
        
        // UI Layer
        let uiStateBuilder = RecipeDetailsUIStateBuilder()
        let viewModel = RecipeDetailsViewModel(
            recipeID: recipeID,
            uiStateBuilder: uiStateBuilder
        )
        let inputManager = RecipeDetailsInputManager(
            recipesUseCase: recipesUseCase,
            favoritesUseCase: favoritesUseCase,
            observers: [viewModel]
        )
        
        return RecipeDetailsHostView(
            viewModel: viewModel,
            inputManager: inputManager
        )
    }
}