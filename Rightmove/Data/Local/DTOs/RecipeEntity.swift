struct RecipeEntity: Codable {
    let id: Int
    let thumbnailURL: String?
    let name: String
    let description: String
    let positiveRatingPercentage: Double?
    let cookingTime: Time?
}
