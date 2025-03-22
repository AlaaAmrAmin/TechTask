struct RecipesListUIState: Equatable {
    let title: String
    let contentState: ContentState
    
    enum ContentState: Equatable {
        case loading
        case loaded(LoadedUIState)
        case error
    }
    
    struct LoadedUIState: Equatable {
        private let recipes: [RecipeUIState]
        let favoritesSectionTitle: String
        
        var showFavoritesSection: Bool {
            !favoriteRecipes.isEmpty
        }
        
        var favoriteRecipes: [RecipeUIState] {
            recipes.filter { $0.isFavorite }
        }
        
        var nonFavoriteRecipes: [RecipeUIState] {
            recipes.filter { !$0.isFavorite }
        }
        
        init(recipes: [RecipeUIState], favoritesSectionTitle: String) {
            self.recipes = recipes
            self.favoritesSectionTitle = favoritesSectionTitle
        }
    }
}
