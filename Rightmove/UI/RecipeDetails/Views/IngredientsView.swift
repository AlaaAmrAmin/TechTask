import SwiftUI

struct IngredientsView: View {
    let ingredients: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: UISpacing.medium) {
            Text("Ingredients")
                .font(.headline)
            
            ForEach(ingredients, id: \.self) { ingredient in
                Text(ingredient)
            }
        }
    }
}
