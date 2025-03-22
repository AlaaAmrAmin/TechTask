import SwiftUI

protocol RecipeDetailsInputManaging {
    func fetchRecipeDetails(with id: Int)
}

struct RecipeDetailsHostView: View {
    @ObservedObject private var viewModel: RecipeDetailsViewModel
    private let inputManager: RecipeDetailsInputManaging & RecipeDetailsInputHandling
    
    init(
        viewModel: RecipeDetailsViewModel,
        inputManager: RecipeDetailsInputManaging & RecipeDetailsInputHandling
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
            .onAppear {
                inputManager.fetchRecipeDetails(with: viewModel.recipeID)
            }
        }
    }
}
