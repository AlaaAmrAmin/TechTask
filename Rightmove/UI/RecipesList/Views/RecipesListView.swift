import SwiftUI

struct RecipesListView<DetailsView: View>: View {
    private let uiState: RecipesListUIState
    @State var showFavorites: Bool = true
    private let recipeDetailsView: (Int) -> DetailsView
    
    init(
        uiState: RecipesListUIState,
        recipeDetailsView: @escaping (Int) -> DetailsView
    ) {
        self.uiState = uiState
        self.recipeDetailsView = recipeDetailsView
    }
    
    var body: some View {
        switch uiState.contentState {
        case .loading:
            loadingView
        case .loaded(let content):
            VStack(spacing: UISpacing.medium) {
                FavoriteButton(
                    isSelected: showFavorites,
                    onFavoriteToggle: { _ in
                        showFavorites.toggle()
                    }
                )
                constructRecipesSection(from: content)
            }
        case .error:
            errorView
        }
    }
    
    private var loadingView: some View {
        ProgressView("Loading...")
            .progressViewStyle(.circular)
    }
    
    private var errorView: some View {
        Text("Failed to load recipes")
            .font(.title)
            .foregroundColor(.red)
    }
    
    @ViewBuilder
    private func constructRecipesSection(from contentState: RecipesListUIState.LoadedUIState) -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                if showFavorites && contentState.showFavoritesSection {
                    Text(contentState.favoritesSectionTitle)
                        .font(.largeTitle)
                    recipesList(contentState.favoriteRecipes)
                    Divider()
                    Text("Remote Recipes")
                        .font(.largeTitle)
                }
                recipesList(contentState.nonFavoriteRecipes)
            }
        }
        .padding(.horizontal, 16)
    }
    
    private func recipesList(_ recipes: [RecipeUIState]) -> some View {
        LazyVStack(alignment: .leading) {
            ForEach(recipes) { recipe in
                NavigationLink {
                    recipeDetailsView(recipe.id)
                } label: {
                    RecipeCardView(uiState: recipe)
                        .background(.gray.opacity(0.25))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
    }
}

#Preview("Content") {
    RecipesListView<Text>(
        uiState: StubbedRecipesListUIState.content,
        recipeDetailsView: { _ in  Text("Recipe details view")}
    )
}

struct StubbedRecipesListUIState {
    static var loading: RecipesListUIState {
        .init(
            title: "Tasty Recipes",
            contentState: .loading
        )
    }
    
    static var content: RecipesListUIState {
        let favorites: [RecipeUIState] = [
            .init(
                id: 1,
                imageURL: nil,
                title: "Garlic Parmesan Pasta",
                cookingDuration: "1 hr 10 mins",
                rating: "80%",
                isFavorite: true
            ),
            .init(
                id: 2,
                imageURL: nil,
                title: "Smash Bruger",
                cookingDuration: "30 mins",
                rating: "100%",
                isFavorite: true
            )
        ]
        
        let nonFavorites: [RecipeUIState] = [
            .init(
                id: 3,
                imageURL: nil,
                title: "Spinach Soup",
                cookingDuration: "2 hrs",
                rating: "60%",
                isFavorite: false
            )
        ]
        
        return .init(
            title: "Tasty Recipes",
            contentState: .loaded(
                RecipesListUIState.LoadedUIState(
                    recipes: favorites + nonFavorites,
                    favoritesSectionTitle: "Favorites"
                )
            )
        )
    }
}
