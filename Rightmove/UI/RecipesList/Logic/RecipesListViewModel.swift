import Foundation

@MainActor
class RecipesListViewModel: ObservableObject {
    @Published private(set) var uiState: RecipesListUIState
    private let uiStateBuilder: RecipesListUIStateBuilding
    
    init(
        uiStateBuilder: RecipesListUIStateBuilding
    ) {
        self.uiStateBuilder = uiStateBuilder
        self.uiState = uiStateBuilder.buildLoadingState()
    }

}

extension RecipesListViewModel: RecipesDomainOutputObserving {
    func recipesListDidFetch(_ recipes: [Recipes.RecipeOverview]) async {
        uiState = uiStateBuilder.buildContentState(from: recipes)
    }
    
    func recipesListDidFail(with error: Error) async{
        uiState = uiStateBuilder.buildErrorState()
    }
}

extension RecipesListViewModel: RecipeFavoritingOutputObserving {
    func recipeDidFavorite(recipeID: Int) async {
        uiState = uiStateBuilder.buildStateWithUpdatedFavoriteStatus(
            currentState: uiState,
            markRecipeWithID: recipeID,
            asFavorite: true
        )
    }
    
    func recipeDidUnfavorite(recipeID: Int) async {
        uiState = uiStateBuilder.buildStateWithUpdatedFavoriteStatus(
            currentState: uiState,
            markRecipeWithID: recipeID,
            asFavorite: false
        )
    }
}
