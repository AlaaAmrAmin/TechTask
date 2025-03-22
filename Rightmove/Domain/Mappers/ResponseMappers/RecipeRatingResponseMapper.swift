struct RecipeRatingResponseMapper: ResponseDomainMapping {
    func map(_ dto: RecipeDTO.RatingDTO) -> Double {
        return Double(dto.positiveCount / (dto.positiveCount + dto.negativeCount)) * 100
    }
}
