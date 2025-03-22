import SwiftUI

struct RecipeHeaderView: View {
    let details: RecipeDetailsUIState.RecipeDetails
    let onFavoriteToggle: (Bool) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            image
            description
            rating
            time
        }
    }
    
    private var image: some View {
        AsyncImage(url: details.imageURL) { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
            Image("placeholder")
                .aspectRatio(contentMode: .fill)
        }
        .frame(height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var description: some View {
        VStack(spacing: 8){
            HStack {
                Spacer()
                
                FavoriteButton(
                    isSelected: details.isFavorite,
                    onFavoriteToggle: { _ in
                        onFavoriteToggle(!details.isFavorite)
                    }
                )
            }
            
            Text(details.description)
                .font(.body)
        }
    }
    
    @ViewBuilder
    private var rating: some View {
        if let rating = details.rating {
            Text("Rating: \(rating)")
                .font(.subheadline)
        }
    }
    
    private var time: some View {
        HStack {
            if let prep = details.prepTime {
                Text("Prep: \(prep)")
            }
            if let cooking = details.cookingTime {
                Text("Cook: \(cooking)")
            }
        }
        .font(.subheadline)
    }
}
