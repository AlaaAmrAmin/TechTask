struct NutritionView: View {
    let nutrition: RecipeDetailsUIState.RecipeDetails.NutritionUIState
    
    var body: some View {
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
}
