import Foundation

protocol RecipeDetailsUIStateBuilding {
    func buildLoadingState() -> RecipeDetailsUIState
    func buildContentState(from recipe: Recipe) -> RecipeDetailsUIState
    func buildUpdatedContentState(currentState: RecipeDetailsUIState, isFavorite: Bool) -> RecipeDetailsUIState
    func buildErrorState() -> RecipeDetailsUIState
}

struct RecipeDetailsUIStateBuilder: RecipeDetailsUIStateBuilding {
    private let timeFormatter: TimeUIFormatting
    
    init(timeFormatter: some TimeUIFormatting) {
        self.timeFormatter = timeFormatter
    }
    
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
                    prepTime: recipe.prepTime.flatMap(timeFormatter.formatTime),
                    cookingTime: recipe.cookingTime.flatMap(timeFormatter.formatTime),
                    instructions: buildInstructions(recipe.instructions),
                    ingredients: buildIngredients(recipe.ingredients),
                    nutrition: recipe.nutrition.map(buildNutritionState),
                    isFavorite: recipe.isFavorite
                )
            )
        )
    }
    
    func buildUpdatedContentState(currentState: RecipeDetailsUIState, isFavorite: Bool) -> RecipeDetailsUIState {
        guard case var .loaded(recipe) = currentState.contentState else {
            return currentState
        }
        
        recipe.isFavorite = isFavorite
        
        return .init(
            title: currentState.title,
            contentState: .loaded(recipe)
        )
    }
    
    func buildErrorState() -> RecipeDetailsUIState {
        .init(
            title: Copy.title,
            contentState: .error
        )
    }
    
    private func buildNutritionState(_ nutrition: Recipe.Nutrition) -> RecipeDetailsUIState.RecipeDetails.NutritionUIState {
        .init(
            info: [
                ("Calories", "\(nutrition.calories)cal"),
                ("Carbs", "\(nutrition.carbohydrates)g"),
                ("Fat", "\(nutrition.fat)g"),
                ("Fiber", "\(nutrition.fiber)g"),
                ("Protein", "\(nutrition.protein)g"),
                ("Sugar", "\(nutrition.sugar)g")
            ]
        )
    }
    
    private func buildInstructions(_ instructions: [Recipe.Instruction]) -> [String] {
        var formattedInstructions = [String]()
        for i in 0 ..< instructions.count {
            formattedInstructions.append("\(i + 1). \(instructions[i].description)")
        }
        return formattedInstructions
    }
    
    private func buildIngredients(_ ingredients: [Recipe.Ingredient]) -> [String] {
        var formattedIngredients = [String]()
        for i in 0 ..< ingredients.count {
            formattedIngredients.append("• \(ingredients[i].description)")
        }
        return formattedIngredients
    }
}

private extension RecipeDetailsUIStateBuilder {
    enum Copy {
        static let title = "Recipe Details"
    }
}
