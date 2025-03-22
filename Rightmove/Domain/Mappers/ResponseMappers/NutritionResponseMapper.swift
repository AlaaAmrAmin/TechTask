struct NutritionResponseMapper: ResponseDomainMapping {
    func map(_ dto: RecipeDTO.NutritionDTO) -> Recipe.Nutrition {
        Recipe.Nutrition(
            calories: dto.calories,
            carbohydrates: dto.carbohydrates,
            fat: dto.fat,
            fiber: dto.fiber,
            protein: dto.protein,
            sugar: dto.sugar
        )
    }
}
