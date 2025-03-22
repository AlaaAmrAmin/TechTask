struct InstructionsView: View {
    let instructions: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Instructions")
                .font(.headline)
            
            ForEach(Array(instructions.enumerated()), id: \.offset) { index, instruction in
                Text("\(index + 1). \(instruction)")
                    .padding(.bottom, 4)
            }
        }
    }
}