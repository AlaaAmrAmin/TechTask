import SwiftUI

struct NutritionView: View {
    let nutrition: RecipeDetailsUIState.RecipeDetails.NutritionUIState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Nutrition")
                .font(.headline)
            
            let info = nutrition.info
            
            HStack {
                ForEach(0 ..< info.count / 2, id: \.self) { index in
                    nutritionItem(info[index].info, info[index].nutrition)
                }
            }
            
            HStack {
                ForEach(info.count / 2 ..< info.count, id: \.self) { index in
                    nutritionItem(info[index].info, info[index].nutrition)
                }
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
