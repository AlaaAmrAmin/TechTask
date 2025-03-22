protocol RecipesEntityMapping: Sendable {
    func map(_ entities: [RecipeEntity]) -> Recipes
}

struct RecipesEntityMapper: RecipesEntityMapping {
    private let recipeMapper: RecipeEntityMapping
    
    init(recipeMapper: RecipeEntityMapping = RecipeEntityMapper()) {
        self.recipeMapper = recipeMapper
    }
    
    func map(_ entities: [RecipeEntity]) -> Recipes {
        return Recipes(
            list: entities.map(recipeMapper.map),
            totalNumberOfRecipes: entities.count
        )
    }
}
