import Foundation

@MainActor
class RecipeDetailsViewModel: ObservableObject, RecipeDetailsOutputObserving {
    @Published private(set) var uiState: RecipeDetailsUIState
    private let uiStateBuilder: RecipeDetailsUIStateBuilding
    private let recipe: Recipe
    private var isFavorite: Bool
    
    init(
        recipe: Recipe,
        isFavorite: Bool,
        uiStateBuilder: RecipeDetailsUIStateBuilding
    ) {
        self.recipe = recipe
        self.isFavorite = isFavorite
        self.uiStateBuilder = uiStateBuilder
        self.uiState = uiStateBuilder.buildState(from: recipe, isFavorite: isFavorite, showError: false)
    }
    
    func recipeDidFavorite() async {
        isFavorite = true
        uiState = uiStateBuilder.buildState(from: recipe, isFavorite: true, showError: false)
    }
    
    func recipeDidUnfavorite() async {
        isFavorite = false
        uiState = uiStateBuilder.buildState(from: recipe, isFavorite: false, showError: false)
    }
    
    func recipeActionDidFail(with error: Error) async {
        uiState = uiStateBuilder.buildState(from: recipe, isFavorite: isFavorite, showError: true)
    }
}
