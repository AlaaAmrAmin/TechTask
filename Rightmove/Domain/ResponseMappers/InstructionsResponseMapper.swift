struct InstructionsResponseMapper: ResponseDomainMapping {
    func map(_ dto: [RecipeDTO.InstructionDTO]) -> [Recipe.Instruction] {
        let sortedInstructions = dto.sorted { $0.position < $1.position }
        
        return sortedInstructions.map { instructionDTO in
            Recipe.Instruction(description: instructionDTO.description)
        }
    }
}
