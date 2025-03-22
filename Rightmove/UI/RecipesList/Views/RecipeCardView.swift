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
        Image(uiImage: uiState.image)
            .resizable()
            .scaledToFill()
            .frame(width: 150)
            .clipped()
    }
    
    var title: some View {
        Text(uiState.title)
            .font(.title3)
    }
    
    var cookingDuration: some View {
        HStack(spacing: UISpacing.small) {
            Image(systemName: "clock.fill")
                .foregroundStyle(.white)
            Text(uiState.cookingDuration)
        }
    }
    
    var rating: some View {
        HStack(spacing: UISpacing.medium) {
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)
            Text(uiState.rating)
        }
    }
}

#Preview {
    RecipeCardView(uiState: .init(
        id: 1,
        image: UIImage(named: "placeholder")!,
        title: "Garlic Parmesan Pasta",
        cookingDuration: "1 hr 10 mins",
        rating: "80%"
    )
    )
}
