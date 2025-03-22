import Foundation

struct RecipeDetailsUIState {
    let title: String
    let contentState: ContentState
    
    enum ContentState {
        case loading
        case loaded(RecipeDetails)
        case error
    }
    
    struct RecipeDetails {
        let title: String
        let description: String
        let imageURL: URL?
        let rating: String?
        let prepTime: String?
        let cookingTime: String?
        let instructions: [String]
        let ingredients: [String]
        let nutrition: NutritionUIState?
        var isFavorite: Bool
        
        struct NutritionUIState {
            let info: [(nutrition: String, info: String)]
        }
    }
}
