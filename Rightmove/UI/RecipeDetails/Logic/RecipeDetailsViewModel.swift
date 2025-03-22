import Foundation

@MainActor
class RecipeDetailsViewModel: ObservableObject {
    @Published private(set) var uiState: RecipeDetailsUIState
    private let uiStateBuilder: RecipeDetailsUIStateBuilding
    let recipeID: Int
    
    init(
        recipeID: Int,
        uiStateBuilder: RecipeDetailsUIStateBuilding
    ) {
        self.recipeID = recipeID
        self.uiStateBuilder = uiStateBuilder
        self.uiState = uiStateBuilder.buildLoadingState()
    }
}

extension RecipeDetailsViewModel: RecipeDetailsFetchingOutputObserving {
    func recipeDidFetchDetails(_ recipe: Recipe) async {
        print("Show recipe \(recipe.name)")
        uiState = uiStateBuilder.buildContentState(from: recipe)
    }
    
    func recipeDetailsDidFail() async {
        uiState = uiStateBuilder.buildErrorState()
    }
}

extension RecipeDetailsViewModel: RecipeFavoritingOutputObserving {
    func recipeDidFavorite(recipeID: Int) async {
        print("Favorite recipe")
        uiState = uiStateBuilder.buildUpdatedContentState(currentState: uiState, isFavorite: true)
    }
    
    func recipeDidUnfavorite(recipeID: Int) async {
        print("UnFavorite recipe")
        uiState = uiStateBuilder.buildUpdatedContentState(currentState: uiState, isFavorite: false)
    }
}
