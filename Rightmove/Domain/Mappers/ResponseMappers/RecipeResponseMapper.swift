import Foundation

struct RecipeResponseMapper: ResponseDomainMapping {
    private let ratingMapper: any ResponseRatingMapping
    private let timeMapper: any ResponseTimeMapping
    private let instructionsMapper: any ResponseInstructionsMapping
    private let ingredientsMapper: any ResponseIngredientsMapping
    private let nutritionMapper: any ResponseNutritionMapping
    
    internal init(
        ratingMapper: some ResponseRatingMapping,
        timeMapper: some ResponseTimeMapping,
        instructionsMapper: some ResponseInstructionsMapping,
        ingredientsMapper: some ResponseIngredientsMapping,
        nutritionMapper: some ResponseNutritionMapping
    ) {
        self.ratingMapper = ratingMapper
        self.timeMapper = timeMapper
        self.instructionsMapper = instructionsMapper
        self.ingredientsMapper = ingredientsMapper
        self.nutritionMapper = nutritionMapper
    }
    
    func map(_ dto: RecipeDTO) -> Recipe {
        return Recipe(
            id: dto.id,
            thumbnailURL: dto.thumbnailURL.flatMap { URL(string: $0) },
            name: dto.name,
            description: dto.description,
            positiveRatingPercentage: dto.rating.map(ratingMapper.map),
            prepTime: dto.prepTimeInMinutes.flatMap(timeMapper.map),
            cookingTime: dto.cookingTimeInMinutes.flatMap(timeMapper.map),
            instructions: instructionsMapper.map(dto.instructions),
            ingredients: ingredientsMapper.map(dto.sections.first?.components ?? []),
            nutrition: dto.nutrition.map(nutritionMapper.map),
            isFavorite: false
        )
    }
}
