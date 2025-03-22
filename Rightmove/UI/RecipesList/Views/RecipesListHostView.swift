import SwiftUI

protocol RecipesListInputManaging {
    func fetchRecipes()
}

struct RecipesListHostView: View {
    @ObservedObject private var viewModel: RecipesListViewModel
    private let inputManager: RecipesListInputManaging
    
    init(
        viewModel: RecipesListViewModel,
        inputManager: RecipesListInputManaging
    ) {
        self.viewModel = viewModel
        self.inputManager = inputManager
    }

    var body: some View {
        NavigationStack {
            RecipesListView(
                uiState: viewModel.uiState
            )
            .navigationTitle(viewModel.uiState.title)
            .navigationBarTitleDisplayMode(.automatic)
            .onAppear {
                inputManager.fetchRecipes()
            }
        }
    }
}

#Preview {
    RecipesListHostView(
        viewModel: .init(uiStateBuilder: RecipesListUIStateBuilder()),
        inputManager: InputManagerStub()
    )
}

private struct InputManagerStub: RecipesListInputManaging {
    func fetchRecipes() {}
}
