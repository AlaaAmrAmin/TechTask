import Foundation

struct RecipesResponseMapper: ResponseDomainMapping {
    private let ratingMapper: any ResponseDomainMapping<RecipeDTO.RatingDTO, Double>
    private let timeMapper: any ResponseDomainMapping<String, Time>
    
    func map(_ dto: RecipesDTO) -> Recipes {
        Recipes(
            list: dto.recipes.map { recipeDTO in
                Recipes.RecipeOverview(
                    id: recipeDTO.id,
                    thumbnailURL: recipeDTO.thumbnailURL,
                    name: recipeDTO.name,
                    description: recipeDTO.description,
                    positiveRatingPercentage: recipeDTO.rating.map(ratingMapper.map),
                    cookingTime: recipeDTO.cookingTimeInMinutes.map(timeMapper.map)
                )
            },
            totalNumberOfRecipes: dto.totalNumberOfRecipes
        )
    }
}
