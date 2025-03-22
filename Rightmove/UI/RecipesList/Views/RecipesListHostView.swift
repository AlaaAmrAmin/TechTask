import SwiftUI

protocol RecipesListInputManaging {
    func fetchRecipes()
}

struct RecipesListHostView: View {
    @ObservedObject private var viewModel: RecipesListViewModel
    private let inputManager: RecipesListInputManaging
    private let recipesListView: () -> RecipesListView<RecipeDetailsHostView>
   
    @State private var fetchRecipes = true
    
    init(
        viewModel: RecipesListViewModel,
        inputManager: RecipesListInputManaging,
        recipesListView: @escaping () -> RecipesListView<RecipeDetailsHostView>
    ) {
        self.viewModel = viewModel
        self.inputManager = inputManager
        self.recipesListView = recipesListView
    }

    var body: some View {
        NavigationStack {
            recipesListView()
            .navigationTitle(viewModel.uiState.title)
            .navigationBarTitleDisplayMode(.automatic)
            .onAppear {
                if fetchRecipes {
                    fetchRecipes = false
                    inputManager.fetchRecipes()
                }
            }
        }
    }
}
