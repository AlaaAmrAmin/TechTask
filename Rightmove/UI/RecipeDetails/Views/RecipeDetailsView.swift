import SwiftUI

protocol RecipeDetailsInputHandling {
    func markRecipeAsFavorite(_ isFavorite: Bool)
}

struct RecipeDetailsView: View {
    private let uiState: RecipeDetailsUIState
    private let inputManager: RecipeDetailsInputHandling
    
    init(
        uiState: RecipeDetailsUIState,
        inputManager: RecipeDetailsInputHandling
    ) {
        self.uiState = uiState
        self.inputManager = inputManager
    }
    
    var body: some View {
        Group {
            switch uiState.contentState {
            case .loading:
                loadingView
            case .loaded(let details):
                contentView(details)
            case .error:
                errorView
            }
        }
    }
    
    private var loadingView: some View {
        ProgressView("Loading...")
            .progressViewStyle(.circular)
    }
    
    private var errorView: some View {
        VStack {
            Text("Failed to load recipe details")
                .foregroundColor(.red)
        }
    }
    
    private func contentView(_ details: RecipeDetailsUIState.RecipeDetails) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: UISpacing.large) {
                RecipeHeaderView(
                    details: details,
                    onFavoriteToggle: inputManager.markRecipeAsFavorite
                )
                
                if let nutrition = details.nutrition {
                    NutritionView(nutrition: nutrition)
                }
                
                if !details.ingredients.isEmpty {
                    IngredientsView(ingredients: details.ingredients)
                }
                
                if !details.instructions.isEmpty {
                    InstructionsView(instructions: details.instructions)
                }
            }
            .padding()
        }
    }
}


