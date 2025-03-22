protocol RecipesDomainOutputObserving: Sendable {
    func recipesListDidFetch(_ recipes: [Recipes.RecipeOverview]) async
    func recipesListDidFail(with error: Error) async /// Could create a domain Error type and pass it here
}

struct RecipesListInputManager {
    private let useCase: RecipesInput
    private let observers: [RecipesDomainOutputObserving] // Using an array provides the flexibility of adding more observers (like loggers) in the future without changing the code.
    private let observersNotifier: ObserverNotifiable
    
    init(
        useCase: some RecipesInput,
        observers: [any RecipesDomainOutputObserving],
        observersNotifier: some ObserverNotifiable
    ) {
        self.useCase = useCase
        self.observers = observers
        self.observersNotifier = observersNotifier
    }
}

extension RecipesListInputManager: RecipesListInputManaging {
    func fetchRecipes() {
        Task { [useCase, observers] in
            do {
                let recipes = try await useCase.fetchRecipes()
                
                await observersNotifier.notify(observers: observers) {
                    await $0.recipesListDidFetch(recipes)
                }
            } catch {
                print(error)
                
                await observersNotifier.notify(observers: observers) {
                    await $0.recipesListDidFail(with: error)
                }
            }
        }
    }
}
