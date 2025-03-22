extension RecipesListUIState {
    static func stubContent(recipes: [RecipeUIState]) -> RecipesListUIState {
        let state = RecipesListUIState(
            title: "Recipes",
            contentState: .loaded(
                RecipesListUIState.LoadedUIState(
                    recipes: recipes,
                    favoritesSectionTitle: "Favorites"
                )
            )
        )
    }
}
