import Foundation

protocol RecipeDetailsUIStateBuilding {
    func buildLoadingState() -> RecipeDetailsUIState
    func buildContentState(from recipe: Recipe) -> RecipeDetailsUIState
    func buildErrorState() -> RecipeDetailsUIState
}

struct RecipeDetailsUIStateBuilder: RecipeDetailsUIStateBuilding {
    func buildLoadingState() -> RecipeDetailsUIState {
        .init(
            title: Copy.title,
            contentState: .loading
        )
    }
    
    func buildContentState(from recipe: Recipe) -> RecipeDetailsUIState {
        .init(
            title: Copy.title,
            contentState: .loaded(
                .init(
                    title: recipe.name,
                    description: recipe.description,
                    imageURL: recipe.thumbnailURL,
                    rating: recipe.positiveRatingPercentage.map { "\(Int($0))%" },
                    prepTime: recipe.prepTime.map { formatTime($0) },
                    cookingTime: recipe.cookingTime.map { formatTime($0) },
                    instructions: recipe.instructions.map(\..description),
                    ingredients: recipe.ingredients.map(\..description),
                    nutrition: recipe.nutrition.map(buildNutritionState),
                    isFavorite: false
                )
            )
        )
    }
    
    func buildErrorState() -> RecipeDetailsUIState {
        .init(
            title: Copy.title,
            contentState: .error
        )
    }
    
    private func formatTime(_ time: Time) -> String {
        let hours = time.hours == 1 ? "hour" : "hours"
        let minutes = time.minutes == 1 ? "minute" : "minutes"
        return "\(time.hours)\(hours) \(time.minutes)\(minutes)"
    }
    
    private func buildNutritionState(_ nutrition: Recipe.Nutrition) -> RecipeDetailsUIState.RecipeDetails.NutritionUIState {
        .init(
            calories: "\(nutrition.calories)cal",
            carbohydrates: "\(nutrition.carbohydrates)g",
            fat: "\(nutrition.fat)g",
            fiber: "\(nutrition.fiber)g",
            protein: "\(nutrition.protein)g",
            sugar: "\(nutrition.sugar)g"
        )
    }
}

private extension RecipeDetailsUIStateBuilder {
    enum Copy {
        static let title = "Recipe Details"
    }
}
