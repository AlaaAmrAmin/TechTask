struct IngredientsResponseMapper: ResponseDomainMapping {
    func map(_ dto: [RecipeDTO.SectionDTO.ComponentDTO]) -> [Recipe.Ingredient] {
        let sortedIngredients = dto.sorted { $0.position < $1.position }
        
        return sortedIngredients.map { ingredientDTO in
            Recipe.Ingredient(description: ingredientDTO.description)
        }
    }
}
