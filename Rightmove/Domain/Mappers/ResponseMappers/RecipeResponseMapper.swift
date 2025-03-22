import Foundation

struct RecipeResponseMapper: ResponseDomainMapping {
    private let ratingMapper: any ResponseDomainMapping<RecipeDTO.RatingDTO, Double>
    private let timeMapper: any ResponseDomainMapping<String, Time>
    private let instructionsMapper: any ResponseDomainMapping<RecipeDTO.InstructionDTO, Recipe.Instruction>
    private let ingredientsMapper: any ResponseDomainMapping<RecipeDTO.SectionDTO.ComponentDTO, Recipe.Ingredient>
    private let nutritionMapper: any ResponseDomainMapping<RecipeDTO.NutritionDTO, Recipe.Nutrition>
    
    func map(_ dto: RecipeDTO) -> Recipe {
        return Recipe(
            id: dto.id,
            thumbnailURL: dto.thumbnailURL.flatMap { URL(string: $0) },
            name: dto.name,
            description: dto.description,
            positiveRatingPercentage: dto.rating.map(ratingMapper.map),
            prepTime: dto.prepTimeInMinutes.map(timeMapper.map),
            cookingTime: dto.cookingTimeInMinutes.map(timeMapper.map),
            instructions: dto.instructions.map(instructionsMapper.map),
            ingredients: dto.sections.first?.components.map(ingredientsMapper.map) ?? [],
            nutrition: dto.nutrition.map(nutritionMapper.map)
        )
    }
}
