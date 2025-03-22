import SwiftUI

struct RecipeCardView: View {
    private let uiState: RecipeUIState
    
    init(uiState: RecipeUIState) {
        self.uiState = uiState
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: UISpacing.small) {
            image
            
            VStack(alignment: .leading, spacing: UISpacing.small){
                title
                cookingDuration
                    .padding(.bottom, UISpacing.medium)
                Spacer()
                rating
            }
            .padding(.horizontal)
            .padding(.vertical, UISpacing.large)
            
            Spacer()
        }
    }
    
    var image: some View {
        AsyncImage(url: uiState.imageURL) { image in
            image
                .resizable()
        } placeholder: {
            Image("placeholder")
                .resizable()
                
        }
        .scaledToFill()
        .frame(width: 150)
        .clipped()
    }
    
    var title: some View {
        Text(uiState.title)
            .font(.title3)
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
    }
    
    @ViewBuilder
    var cookingDuration: some View {
        if let duration = uiState.cookingDuration {
            HStack(spacing: UISpacing.small) {
                Image(systemName: "clock.fill")
                    .foregroundStyle(.white)
                Text(duration)
            }
        }
    }
    
    @ViewBuilder
    var rating: some View {
        if let rating = uiState.rating {
            HStack(spacing: UISpacing.medium) {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                Text(rating)
            }
        }
    }
}

#Preview {
    let uiStates: [RecipeUIState] = [
        .init(
            id: 1,
            imageURL: nil,
            title: "Garlic Parmesan Pasta",
            cookingDuration: "1 hr 10 mins",
            rating: "80%",
            isFavorite: false
        ),
        .init(
            id: 2,
            imageURL: nil,
            title: "Garlic Parmesan Pasta",
            cookingDuration: nil,
            rating: "80%",
            isFavorite: false
        ),
        .init(
            id: 3,
            imageURL: nil,
            title: "Garlic Parmesan Pasta",
            cookingDuration: "1 hr 10 mins",
            rating: nil,
            isFavorite: false
        ),
        .init(
            id: 4,
            imageURL: nil,
            title: "Garlic Parmesan Pasta",
            cookingDuration: nil,
            rating: nil,
            isFavorite: false
        )
    ]
    VStack {
        ForEach(uiStates, id: \.id) { uiState in
            RecipeCardView(uiState: uiState)
            .frame(minHeight: 150)
            .background(.gray.opacity(0.25))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(UISpacing.medium)
        }
    }
    
}
