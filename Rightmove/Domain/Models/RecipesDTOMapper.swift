import Foundation

struct RecipesDTOMapper {
    static func map(_ dto: RecipesDTO) -> Recipes {
        Recipes(
            list: dto.recipes.map { recipeDTO in
                Recipes.RecipeOverview(
                    thumbnailURL: recipeDTO.thumbnailURL,
                    name: recipeDTO.name,
                    description: recipeDTO.description,
                    rating: recipeDTO.rating.map { ratingDTO in
                        RecipeRating(
                            positiveCount: ratingDTO.positiveCount,
                            negativeCount: ratingDTO.negativeCount
                        )
                    },
                    cookingTimeInMinutes: recipeDTO.cookingTimeInMinutes
                )
            },
            totalNumberOfRecipes: dto.totalNumberOfRecipes
        )
    }
}

