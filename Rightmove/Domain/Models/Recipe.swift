import Foundation

struct Recipe {
    let id: Int
    let thumbnailURL: URL?
    let name: String
    let description: String
    let positiveRatingPercentage: Double?
    let prepTime: Time?
    let cookingTime: Time?
    let instructions: [Instruction]
    let ingredients: [Ingredient]
    let nutrition: Nutrition?
    var isFavorite: Bool
}

extension Recipe {
    /// Using a separate type for instructions allows for future flexibility,
    /// such as adding images, or additional metadata.
    struct Instruction {
        let description: String
    }
}

extension Recipe {
    struct Nutrition {
        let calories: Int
        let carbohydrates: Int
        let fat: Int
        let fiber: Int
        let protein: Int
        let sugar: Int
    }
}

extension Recipe {
    /// Using a separate type for ingredients allows for future flexibility,
    /// such as adding images, or additional metadata.
    struct Ingredient {
        let description: String
    }
}
