struct IngredientsView: View {
    let ingredients: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Ingredients")
                .font(.headline)
            
            ForEach(ingredients, id: \.self) { ingredient in
                Text("• \(ingredient)")
            }
        }
    }
}
