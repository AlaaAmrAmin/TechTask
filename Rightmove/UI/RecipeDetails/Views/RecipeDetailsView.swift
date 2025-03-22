import SwiftUI

struct RecipeDetailsView: View {
    @ObservedObject private var viewModel: RecipeDetailsViewModel
    private let inputManager: RecipeDetailsInputManaging
    private let recipe: Recipes.RecipeOverview
    
    init(
        viewModel: RecipeDetailsViewModel,
        inputManager: RecipeDetailsInputManaging,
        recipe: Recipes.RecipeOverview
    ) {
        self.viewModel = viewModel
        self.inputManager = inputManager
        self.recipe = recipe
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                headerSection
                
                if let nutrition = viewModel.uiState.nutrition {
                    nutritionSection(nutrition)
                }
                
                ingredientsSection
                instructionsSection
                
                if viewModel.uiState.showError {
                    Text("Failed to update favorite status")
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
        .navigationTitle(viewModel.uiState.title)
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let url = viewModel.uiState.imageURL {
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
                Text(viewModel.uiState.description)
                    .font(.body)
                
                Spacer()
                
                Button(action: {
                    inputManager.toggleFavorite(
                        recipe: recipe,
                        isFavorite: !viewModel.uiState.isFavorite
                    )
                }) {
                    Image(systemName: viewModel.uiState.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                }
            }
            
            if let rating = viewModel.uiState.rating {
                Text("Rating: \(rating)")
                    .font(.subheadline)
            }
            
            HStack {
                if let prep = viewModel.uiState.prepTime {
                    Text("Prep: \(prep)")
                }
                if let cooking = viewModel.uiState.cookingTime {
                    Text("Cook: \(cooking)")
                }
            }
            .font(.subheadline)
        }
    }
    
    private func nutritionSection(_ nutrition: RecipeDetailsUIState.NutritionUIState) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Nutrition")
                .font(.headline)
            
            HStack {
                nutritionItem("Calories", nutrition.calories)
                nutritionItem("Carbs", nutrition.carbohydrates)
                nutritionItem("Fat", nutrition.fat)
            }
            
            HStack {
                nutritionItem("Fiber", nutrition.fiber)
                nutritionItem("Protein", nutrition.protein)
                nutritionItem("Sugar", nutrition.sugar)
            }
        }
    }
    
    private func nutritionItem(_ title: String, _ value: String) -> some View {
        VStack {
            Text(title)
                .font(.caption)
            Text(value)
                .font(.subheadline)
                .bold()
        }
        .frame(maxWidth: .infinity)
    }
    
    private var ingredientsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Ingredients")
                .font(.headline)
            
            ForEach(viewModel.uiState.ingredients, id: \.self) { ingredient in
                Text("• \(ingredient)")
            }
        }
    }
    
    private var instructionsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Instructions")
                .font(.headline)
            
            ForEach(Array(viewModel.uiState.instructions.enumerated()), id: \.offset) { index, instruction in
                Text("\(index + 1). \(instruction)")
                    .padding(.bottom, 4)
            }
        }
    }
}
