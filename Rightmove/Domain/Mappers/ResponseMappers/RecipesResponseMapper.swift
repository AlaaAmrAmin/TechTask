import Foundation

struct RecipesResponseMapper: ResponseDomainMapping {
    private let ratingMapper: any ResponseRatingMapping
    private let timeMapper: any ResponseTimeMapping
    
    init(
        ratingMapper: some ResponseRatingMapping,
        timeMapper: some ResponseTimeMapping
    ) {
        self.ratingMapper = ratingMapper
        self.timeMapper = timeMapper
    }
    
    func map(_ dto: RecipesDTO) -> Recipes {
        Recipes(
            list: dto.recipes.map { recipeDTO in
                Recipes.RecipeOverview(
                    id: recipeDTO.id,
                    thumbnailURL: recipeDTO.thumbnailURL.flatMap { URL(string: $0) },
                    name: recipeDTO.name,
                    description: recipeDTO.description,
                    positiveRatingPercentage: recipeDTO.rating.map(ratingMapper.map),
                    cookingTime: recipeDTO.cookingTimeInMinutes.flatMap(timeMapper.map)
                )
            },
            totalNumberOfRecipes: dto.totalNumberOfRecipes
        )
    }
}
