import Foundation

@MainActor
struct RecipeDetailsViewFactory {
    static func makeView(
        for recipeID: Int,
        favoritingObservers: [RecipeFavoritingOutputObserving]
    ) -> RecipeDetailsHostView {
        let recipesUseCase = RecipesUseCasesFactory.makeRecipesUseCase()
        let favoritesUseCase = RecipesUseCasesFactory.makeFavoriteRecipesUseCase()
        
        
        // UI Layer
        let uiStateBuilder = RecipeDetailsUIStateBuilder(timeFormatter: TimeUIFormatter())
        let viewModel = RecipeDetailsViewModel(
            recipeID: recipeID,
            uiStateBuilder: uiStateBuilder
        )
        let inputManager = RecipeDetailsInputManager(
            recipesUseCase: recipesUseCase,
            favoritesUseCase: favoritesUseCase,
            fetchingObservers: [viewModel],
            favoritingObservers: favoritingObservers + [viewModel],
            observersNotifier: ObserverNotifier()
        )
        
        return RecipeDetailsHostView(
            viewModel: viewModel,
            inputManager: inputManager
        )
    }
}
