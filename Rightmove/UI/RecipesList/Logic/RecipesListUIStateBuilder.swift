import Foundation

protocol RecipesListUIStateBuilding {
    func buildInitialState() -> RecipesListUIState
    func buildContentState(from recipes: [Recipes.RecipeOverview]) -> RecipesListUIState
    func buildUpdatedContentState(currentState: RecipesListUIState, newRecipes: [Recipes.RecipeOverview]) -> RecipesListUIState
}

class RecipesListUIStateBuilder: RecipesListUIStateBuilding {
    private let recipeUIStateMapper: any ResponseDomainMapping<Recipes.RecipeOverview, RecipeUIState>
    
    init(recipeUIStateMapper: some ResponseDomainMapping<Recipes.RecipeOverview, RecipeUIState>) {
        self.recipeUIStateMapper = recipeUIStateMapper
    }
    
    func buildInitialState() -> RecipesListUIState {
        RecipesListUIState(
            title: "Tasty Recipes",
            contentState: .loading
        )
    }
    
    func buildContentState(from recipes: [Recipes.RecipeOverview]) -> RecipesListUIState {
        RecipesListUIState(
            title: "Tasty Recipes",
            contentState: .loaded(recipes.map(recipeUIStateMapper.map))
        )
    }
    
    func buildUpdatedContentState(currentState: RecipesListUIState, newRecipes: [Recipes.RecipeOverview]) -> RecipesListUIState {
        guard case let .loaded(existingRecipes) = currentState.contentState else {
            return buildContentState(from: newRecipes)
        }
        
        return RecipesListUIState(
            title: "Tasty Recipes",
            contentState: .loaded(existingRecipes + newRecipes.map(recipeUIStateMapper.map))
        )
    }
}

