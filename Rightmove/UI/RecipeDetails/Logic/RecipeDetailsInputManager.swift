//
//  RecipeDetailsOutputObserving.swift
//  Rightmove
//
//  Created by Alaa Amin on 22/03/2025.
//


import Foundation

protocol RecipeDetailsOutputObserving: Sendable {
    func recipeDidFavorite() async
    func recipeDidUnfavorite() async
    func recipeActionDidFail(with error: Error) async
}

protocol RecipeDetailsInputManaging {
    func toggleFavorite(recipe: Recipes.RecipeOverview, isFavorite: Bool)
}

class RecipeDetailsInputManager: RecipeDetailsInputManaging {
    private let favoritesUseCase: FavoriteRecipesInput
    private let observers: [RecipeDetailsOutputObserving]
    
    init(
        favoritesUseCase: FavoriteRecipesInput,
        observers: [RecipeDetailsOutputObserving]
    ) {
        self.favoritesUseCase = favoritesUseCase
        self.observers = observers
    }
    
    func toggleFavorite(recipe: Recipes.RecipeOverview, isFavorite: Bool) {
        Task { [weak self] in
            do {
                if isFavorite {
                    try await self?.favoritesUseCase.favorite(recipe)
                    await self?.notifyObservers { await $0.recipeDidFavorite() }
                } else {
                    try await self?.favoritesUseCase.unfavorite(recipe)
                    await self?.notifyObservers { await $0.recipeDidUnfavorite() }
                }
            } catch {
                await self?.notifyObservers { await $0.recipeActionDidFail(with: error) }
            }
        }
    }
    
    private func notifyObservers(_ notification: (RecipeDetailsOutputObserving) async -> Void) async {
        await withTaskGroup(of: Void.self) { group in
            observers.forEach { observer in
                group.addTask {
                    await notification(observer)
                }
            }
        }
    }
}
