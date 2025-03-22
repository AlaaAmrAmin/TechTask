import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            RecipesListViewFactory.makeView()
        } else {
            ZStack {
                Color.white.ignoresSafeArea()
                VStack {
                    Image(systemName: "fork.knife")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .cornerRadius(16)
                    Text("Tasty Recipes")
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
            .onAppear {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
