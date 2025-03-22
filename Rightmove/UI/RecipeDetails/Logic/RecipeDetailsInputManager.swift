import Foundation

protocol RecipeDetailsFetchingOutputObserving: Sendable {
    func recipeDidFetchDetails(_ recipe: Recipe) async
    func recipeDetailsDidFail() async
}

protocol RecipeFavoritingOutputObserving: Sendable {
    func recipeDidFavorite(recipeID: Int) async
    func recipeDidUnfavorite(recipeID: Int) async
}

final class RecipeDetailsInputManager: @unchecked Sendable {
    private let recipesUseCase: RecipesInput
    private let favoritesUseCase: FavoriteRecipesInput
    private let fetchingObservers: [RecipeDetailsFetchingOutputObserving]
    private let favoritingObservers: [RecipeFavoritingOutputObserving]
    private let observersNotifier: ObserverNotifiable
    
    private var recipe: Recipe?
    
    init(
        recipesUseCase: RecipesInput,
        favoritesUseCase: FavoriteRecipesInput,
        fetchingObservers: [RecipeDetailsFetchingOutputObserving],
        favoritingObservers: [RecipeFavoritingOutputObserving],
        observersNotifier: some ObserverNotifiable
    ) {
        self.recipesUseCase = recipesUseCase
        self.favoritesUseCase = favoritesUseCase
        self.fetchingObservers = fetchingObservers
        self.favoritingObservers = favoritingObservers
        self.observersNotifier = observersNotifier
    }
}

extension RecipeDetailsInputManager: RecipeDetailsInputManaging {
    func fetchRecipeDetails(with id: Int) {
        Task {
            do {
                print("Fetch recipe with id \(id)")
                recipe = try await recipesUseCase.fetchRecipe(with: id)
                await observersNotifier.notify(observers: fetchingObservers) {
                    await $0.recipeDidFetchDetails(self.recipe!)
                }
            } catch {
                await observersNotifier.notify(observers: fetchingObservers) {
                    await $0.recipeDetailsDidFail()
                }
            }
        }
    }
    
}

///
/// Needs enhancements to be concurrency safe
///
extension RecipeDetailsInputManager: RecipeDetailsInputHandling {
    func markRecipeAsFavorite(_ isFavorite: Bool) {
        if let recipe {
            Task {
                do {
                    let recipeOverview = Recipes.RecipeOverview(
                        id: recipe.id,
                        thumbnailURL: recipe.thumbnailURL,
                        name: recipe.name,
                        description: recipe.description,
                        positiveRatingPercentage: recipe.positiveRatingPercentage,
                        cookingTime: recipe.cookingTime
                    )
                    
                    if isFavorite {
                        try await favoritesUseCase.favorite(recipeOverview)
                        await observersNotifier.notify(observers: favoritingObservers) {
                            await $0.recipeDidFavorite(recipeID: recipeOverview.id)
                        }
                    } else {
                        try await favoritesUseCase.unfavorite(recipeOverview)
                        await observersNotifier.notify(observers: favoritingObservers) {
                            await $0.recipeDidUnfavorite(recipeID: recipeOverview.id)
                        }
                    }
                } catch {
                    /// Error handling not implemented
                    print(error)
                }
            }
        }
    }
}

