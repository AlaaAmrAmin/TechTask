import Foundation

protocol RecipeEntityMapping: Sendable {
    func map(_ entity: RecipeEntity) -> Recipes.RecipeOverview
    func map(_ overview: Recipes.RecipeOverview) -> RecipeEntity
}

struct RecipeEntityMapper: RecipeEntityMapping {
    func map(_ entity: RecipeEntity) -> Recipes.RecipeOverview {
        return Recipes.RecipeOverview(
            id: entity.id,
            thumbnailURL: entity.thumbnailURL.flatMap { URL(string: $0) },
            name: entity.name,
            description: entity.description,
            positiveRatingPercentage: entity.positiveRatingPercentage,
            cookingTime: entity.cookingTime,
            isFavorite: true
        )
    }
    
    func map(_ overview: Recipes.RecipeOverview) -> RecipeEntity {
        return RecipeEntity(
            id: overview.id,
            thumbnailURL: overview.thumbnailURL?.absoluteString,
            name: overview.name,
            description: overview.description,
            positiveRatingPercentage: overview.positiveRatingPercentage,
            cookingTime: overview.cookingTime
        )
    }
}
