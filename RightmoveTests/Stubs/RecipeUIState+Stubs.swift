@testable import Rightmove

extension RecipeUIState {
    static func stubRecipe(
        cookingDuration: String? = "1 hr 10 mins",
        rating: String = "80%",
        isFavorite: Bool = false
    ) -> RecipeUIState {
        return .init(
            id: 1,
            imageURL: nil,
            title: "Garlic Pasta",
            cookingDuration: cookingDuration,
            rating: rating,
            isFavorite: isFavorite
        )
    }
}
