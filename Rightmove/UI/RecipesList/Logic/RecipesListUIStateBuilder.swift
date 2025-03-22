import Foundation

protocol RecipesListUIStateBuilding {
    func buildLoadingState() -> RecipesListUIState
    func buildContentState(from recipes: [Recipes.RecipeOverview]) -> RecipesListUIState
    func buildUpdatedContentState(currentState: RecipesListUIState, newRecipes: [Recipes.RecipeOverview]) -> RecipesListUIState
    func buildStateWithUpdatedFavoriteStatus(
        currentState: RecipesListUIState,
        markRecipeWithID recipeID: Int,
        asFavorite: Bool
    ) -> RecipesListUIState
    func buildErrorState() -> RecipesListUIState
}

class RecipesListUIStateBuilder: RecipesListUIStateBuilding {
    private let timeFormatter: TimeUIFormatting
    
    init(timeFormatter: some TimeUIFormatting) {
        self.timeFormatter = timeFormatter
    }
    
    func buildLoadingState() -> RecipesListUIState {
        .init(
            title: Copy.title,
            contentState: .loading
        )
    }
    
    func buildContentState(from recipes: [Recipes.RecipeOverview]) -> RecipesListUIState {
        let recipes = recipes.map(buildRecipe)
        return buildLoadedState(recipes: recipes)
    }
    
    func buildUpdatedContentState(
        currentState: RecipesListUIState,
        newRecipes: [Recipes.RecipeOverview]
    ) -> RecipesListUIState {
        guard case let .loaded(state) = currentState.contentState else {
            return buildContentState(from: newRecipes)
        }
        
        let newRecipes = newRecipes.map(buildRecipe)
        let previousRecipes = state.favoriteRecipes + state.nonFavoriteRecipes
        
        return buildLoadedState(recipes: previousRecipes + newRecipes)
    }
    
    func buildStateWithUpdatedFavoriteStatus(
        currentState: RecipesListUIState,
        markRecipeWithID recipeID: Int,
        asFavorite isFavorite: Bool
    ) -> RecipesListUIState {
        guard case let .loaded(state) = currentState.contentState else {
            return currentState
        }
        
        var recipes = state.favoriteRecipes + state.nonFavoriteRecipes
        if let index = recipes.firstIndex(where: { $0.id == recipeID }) {
            recipes[index].isFavorite = isFavorite
        }
        
        return buildLoadedState(recipes: recipes)
    }
    
    func buildErrorState() -> RecipesListUIState {
        .init(
            title: Copy.title,
            contentState: .error
        )
    }
    
    
    // MARK: - Helpers
    
    private func buildLoadedState(recipes: [RecipeUIState]) -> RecipesListUIState {
        let loadedUIState = RecipesListUIState.LoadedUIState(
            recipes: recipes,
            favoritesSectionTitle: Copy.favoritesSectionTitle
        )
        
        return .init(
            title: Copy.title,
            contentState: .loaded(loadedUIState)
        )
    }
        
    private func buildRecipe(_ recipe: Recipes.RecipeOverview) -> RecipeUIState {
        return .init(
            id: recipe.id,
            imageURL: recipe.thumbnailURL,
            title: recipe.name,
            cookingDuration: recipe.cookingTime.flatMap(timeFormatter.formatTime),
            rating: recipe.positiveRatingPercentage.map { "\(Int($0))%" },
            isFavorite: recipe.isFavorite
        )
    }
}

extension RecipesListUIStateBuilder {
    struct Copy {
        static let title = "Tasty Recipes"
        static let favoritesSectionTitle = "Favorites"
    }
}

