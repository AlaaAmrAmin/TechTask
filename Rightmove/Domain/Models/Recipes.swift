import Foundation

struct Recipes {
    var list: [RecipeOverview]
    let totalNumberOfRecipes: Int
}

extension Recipes {
    struct RecipeOverview: Equatable {
        let id: Int
        let thumbnailURL: URL?
        let name: String
        let description: String
        let positiveRatingPercentage: Double?
        let cookingTime: Time?
        var isFavorite: Bool = false
        
        static func == (lhs: RecipeOverview, rhs: RecipeOverview) -> Bool {
            lhs.id == rhs.id
        }
    }
}
