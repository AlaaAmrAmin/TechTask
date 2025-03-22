struct RecipeDetailsHostView: View {
    @ObservedObject private var viewModel: RecipeDetailsViewModel
    private let inputManager: RecipeDetailsInputManaging
    
    init(
        viewModel: RecipeDetailsViewModel,
        inputManager: RecipeDetailsInputManaging
    ) {
        self.viewModel = viewModel
        self.inputManager = inputManager
    }
    
    var body: some View {
        NavigationStack {
            RecipeDetailsView(
                uiState: viewModel.uiState,
                inputManager: inputManager
            )
            .navigationTitle(viewModel.uiState.title)
            .navigationBarTitleDisplayMode(.automatic)
            .onAppear {
                inputManager.fetchRecipeDetails(with: "")
            }
        }
    }
}