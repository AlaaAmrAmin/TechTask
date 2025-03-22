@testable import Rightmove

class SpyRecipesListUIStateBuilder: RecipesListUIStateBuilding {
    private(set) var calls: [Call] = []
    var stubbedUIState = RecipesListUIState.stubContent(recipes: [])
    
    enum Call: Equatable {
        case buildLoading
        case buildContent(recipes: [Recipes.RecipeOverview])
        case buildUpdateContentWithNewRecipes(currentState: RecipesListUIState, newRecipes: [Recipes.RecipeOverview])
        case buildUpdateWithUpdatedFavoriteStatus(currentState: RecipesListUIState, recipeID: Int, asFavorite: Bool)
        case buildError
    }
    
    func buildLoadingState() -> RecipesListUIState {
        calls.append(.buildLoading)
        return stubbedUIState
    }
    
    func buildContentState(from recipes: [Recipes.RecipeOverview]) -> RecipesListUIState {
        calls.append(.buildContent(recipes: recipes))
        return stubbedUIState
    }
    
    func buildUpdatedContentState(
        currentState: RecipesListUIState,
        newRecipes: [Recipes.RecipeOverview]
    ) -> RecipesListUIState {
        calls.append(.buildUpdateContentWithNewRecipes(currentState: currentState, newRecipes: newRecipes))
        return stubbedUIState
    }
    
    func buildStateWithUpdatedFavoriteStatus(
        currentState: RecipesListUIState,
        markRecipeWithID recipeID: Int,
        asFavorite: Bool
    ) -> RecipesListUIState {
        calls.append(.buildUpdateWithUpdatedFavoriteStatus(currentState: currentState, recipeID: recipeID, asFavorite: asFavorite))
        return stubbedUIState
    }
    
    func buildErrorState() -> RecipesListUIState {
        calls.append(.buildError)
        return stubbedUIState
    }
    
    func reset() {
        calls = []
    }
    
}
