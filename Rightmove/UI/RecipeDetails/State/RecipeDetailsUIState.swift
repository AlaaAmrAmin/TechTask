import Foundation

struct RecipeDetailsUIState {
    let title: String
    let description: String
    let imageURL: URL?
    let rating: String?
    let prepTime: String?
    let cookingTime: String?
    let instructions: [String]
    let ingredients: [String]
    let nutrition: NutritionUIState?
    let isFavorite: Bool
    let showError: Bool
    
    struct NutritionUIState {
        let calories: String
        let carbohydrates: String
        let fat: String
        let fiber: String
        let protein: String
        let sugar: String
    }
}
