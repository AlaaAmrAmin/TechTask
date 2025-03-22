//
//  File.swift
//  Rightmove
//
//  Created by Alaa Amin on 22/03/2025.
//


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
