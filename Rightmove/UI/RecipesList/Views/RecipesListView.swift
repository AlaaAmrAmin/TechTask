import SwiftUI

struct RecipesListView: View {
    private let uiState: RecipesListUIState
    
    init(uiState: RecipesListUIState) {
        self.uiState = uiState
    }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(uiState.recipes) { recipe in
                    RecipeCardView(uiState: recipe)
                        .background(.gray.opacity(0.25))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onAppear {
                            if recipe.id == uiState.recipes.last?.id {
                                print("On Appear")
                            }
                        }
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    RecipesListView(
        uiState:
            RecipesListUIState(
                recipes:[
                    .init(
                        id: 1,
                        image: UIImage(named: "placeholder")!,
                        title: "Garlic Parmesan Pasta",
                        cookingDuration: "1 hr 10 mins",
                        rating: "80%"
                    ),
                    .init(
                        id: 2,
                        image: UIImage(named: "placeholder")!,
                        title: "Smash Bruger",
                        cookingDuration: "30 mins",
                        rating: "100%"
                    ),
                    .init(
                        id: 3,
                        image: UIImage(named: "placeholder")!,
                        title: "Spinach Soup",
                        cookingDuration: "2 hrs",
                        rating: "60%"
                    )
                ]
            )
    )
}

struct RecipesListUIState {
    let recipes: [RecipeUIState]
}
