struct RecipeHeaderView: View {
    let details: RecipeDetailsUIState.RecipeDetails
    let onFavoriteToggle: (Bool) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let url = details.imageURL {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            HStack {
                Text(details.description)
                    .font(.body)
                
                Spacer()
                
                Button(action: {
                    onFavoriteToggle(!details.isFavorite)
                }) {
                    Image(systemName: details.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                }
            }
            
            if let rating = details.rating {
                Text("Rating: \(rating)")
                    .font(.subheadline)
            }
            
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
}