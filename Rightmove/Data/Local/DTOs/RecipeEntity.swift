struct RecipeDTO: Encodable {
    let thumbnailURL: String?
    let name: String
    let description: String
    let rating: RatingDTO?
    let cookingTimeInMinutes: String?
}

extension RecipeDTO {
    struct RatingDTO: Encodable {
        let negativeCount: Int
        let positiveCount: Int
    }
}
