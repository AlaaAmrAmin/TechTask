struct RecipeRatingResponseMapper: ResponseDomainMapping {
    func map(_ dto: RecipeDTO.RatingDTO) -> RecipeRating {
        RecipeRating(
            negativeCount: dto.negativeCount,
            positiveCount: dto.positiveCount,
            positivePercentage: calculateRatingPercentage(from: dto)
        )
    }
    
    private func calculateRatingPercentage(from rating: RecipeDTO.RatingDTO) -> Double {
        return Double(rating.positiveCount / (rating.positiveCount + rating.negativeCount)) * 100
    }
}
