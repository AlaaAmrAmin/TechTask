import SwiftUI

struct InstructionsView: View {
    let instructions: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: UISpacing.medium) {
            Text("Instructions")
                .font(.headline)
            
            ForEach(instructions, id: \.self) {
                Text($0)
                    .padding(.bottom, 4)
            }
        }
    }
}
