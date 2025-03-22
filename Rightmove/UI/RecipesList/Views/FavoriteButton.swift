struct FavoriteButton: View {
    @Binding var isSelected: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                isSelected.toggle()
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