import Foundation

struct RecipeUIState: Identifiable, Equatable {
    let id: Int
    let imageURL: URL?
    let title: String
    let cookingDuration: String?
    let rating: String?
    var isFavorite: Bool
}
