struct RecipesDTO: Decodable {
    let recipes: [RecipeDTO]
    let totalNumberOfRecipes: Int
    
    enum CodingKeys: String, CodingKey {
        case recipes = "results"
        case totalNumberOfRecipes = "count"
    }
}
