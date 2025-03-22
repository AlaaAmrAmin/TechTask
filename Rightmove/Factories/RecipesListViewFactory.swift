import Foundation

@MainActor
struct RecipesListViewFactory {
    static func makeView() -> RecipesListHostView {
        let recipesUseCase = RecipesUseCasesFactory.makeRecipesUseCase()
        
        // UI Layer
        let uiStateBuilder = RecipesListUIStateBuilder(timeFormatter: TimeUIFormatter())
        let viewModel = RecipesListViewModel(uiStateBuilder: uiStateBuilder)
        let inputManager = RecipesListInputManager(
            useCase: recipesUseCase,
            observers: [viewModel],
            observersNotifier: ObserverNotifier()
        )
        
        return RecipesListHostView(
            viewModel: viewModel,
            inputManager: inputManager,
            recipesListView: {
                RecipesListView(
                    uiState: viewModel.uiState,
                    recipeDetailsView: { recipeID in
                        RecipeDetailsViewFactory.makeView(
                            for: recipeID,
                            favoritingObservers: [viewModel]
                        )
                    }
                )
            }
        )
    }
}
