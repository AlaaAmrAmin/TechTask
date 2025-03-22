import Foundation

protocol RecipesLocalLoader: Actor {
    func fetchRecipes() async throws -> [RecipeEntity]
    func store(_ recipe: RecipeEntity) async throws
    func delete(_ recipe: RecipeEntity) async throws
}

actor RecipesLocalRepository: RecipesLocalLoader {
    private let client: any JSONStorage<[RecipeEntity]>
    private var readingState: ReadingState = .notStarted
    private var recipes: [RecipeEntity] = []
    
    enum ReadingState {
        case notStarted
        case ongoing(task: Task<[RecipeEntity], Error>)
        case completed
    }
    
    init(client: any JSONStorage<[RecipeEntity]>) {
        self.client = client
    }
    
    func fetchRecipes() async throws -> [RecipeEntity] {
        switch readingState {
        case .notStarted:
            let task = Task {
                return try await client.read()
            }
            readingState = .ongoing(task: task)
            
            let recipes: [RecipeEntity]
            do {
                recipes = try await task.value
            } catch let error as JSONFileError {
                guard case .fileDoesNotExist = error else {
                    throw error
                }
                recipes = []
            } catch {
                throw error
            }
            
            readingState = .completed
            self.recipes = recipes
            return self.recipes
        case .ongoing(let task):
            return try await task.value
        case .completed:
            return self.recipes
        }
    }
    
    ///
    /// These two methods need additional work to be more robust and less error prone, particularly
    /// in cases where they are fired simultaneously with the first one failing and the second one succeeding.
    ///
    func store(_ recipe: RecipeEntity) async throws {
        _ = try await fetchRecipes()
        guard !self.recipes.contains(where: { $0.id == recipe.id }) else { return }
        self.recipes.append(recipe)
        try await client.write(recipes)
    }
    
    func delete(_ recipe: RecipeEntity) async throws {
        _ = try await fetchRecipes()
        self.recipes.removeAll(where: { $0.id == recipe.id })
        try await client.write(recipes)
    }
}

