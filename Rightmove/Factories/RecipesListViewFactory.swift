@MainActor
struct RecipesListViewFactory {
    static func makeView() -> HostView {
        let recipesUseCase = RecipesUseCasesFactory.makeRecipesUseCase()
        
        // UI Layer
        let uiStateBuilder = RecipesListUIStateBuilder()
        let viewModel = RecipesListViewModel(uiStateBuilder: uiStateBuilder)
        let inputManager = RecipesListInputManager(
            useCase: recipesUseCase,
            observers: [viewModel]
        )
        
        return HostView(
            viewModel: viewModel,
            inputManager: inputManager
        )
    }
}
