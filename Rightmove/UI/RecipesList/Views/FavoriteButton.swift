import SwiftUI

struct FavoriteButton: View {
    let isSelected: Bool
    let onFavoriteToggle: (Bool) -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                onFavoriteToggle(!isSelected)
            }) {
                Image(systemName: isSelected ? "heart.fill" : "heart")
                    .foregroundColor(.red)
                    .font(.title2)
                    .padding(8)
                    .background(
                        Circle()
                            .fill(Color.gray.opacity(0.1))
                    )
            }
            .padding(.trailing)
        }
    }
}
