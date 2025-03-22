@testable import Rightmove

extension RecipesListUIState {
    static func stubContent(recipes: [RecipeUIState]) -> RecipesListUIState {
        return RecipesListUIState(
            title: "Recipes",
            contentState: .loaded(
                RecipesListUIState.LoadedUIState(
                    recipes: recipes,
                    favoritesSectionTitle: "Favorites"
                )
            )
        )
    }
    
    static func stubLoading() -> RecipesListUIState {
        return RecipesListUIState(
            title: "Recipes",
            contentState: .loading
        )
    }
    
    static func stubError() -> RecipesListUIState {
        return RecipesListUIState(
            title: "Recipes",
            contentState: .error
        )
    }
}
