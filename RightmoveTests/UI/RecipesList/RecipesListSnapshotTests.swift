import XCTest
import SnapshotTesting
import SwiftUI
import UIKit

@testable import Rightmove

@MainActor
final class RecipesListSnapshotTests: XCTestCase {
    
    func test_whenHasFavoriteRecipes_andShowFavoritesIsTrue_thenShowsBothSections() {
        // When
        let viewController = createView(with: [
            .stubRecipe(isFavorite: true),
            .stubRecipe(isFavorite: false)
        ])
        
        // Then
        assertSnapshot(of: viewController, as: .image)
    }
    
    func test_whenNoFavoriteRecipes_andShowFavoritesIsTrue_thenShowsOnlyNonFavorites() {
        // When
        let viewController = createView(with: [
            .stubRecipe(isFavorite: false),
            .stubRecipe(isFavorite: false)
        ])
        
        // Then
        assertSnapshot(of: viewController, as: .image)
    }
    
    func test_whenHasFavoriteRecipes_andShowFavoritesIsFalse_thenShowsOnlyNonFavorites() {
        // When
        let viewController = createView(
            with: [
                .stubRecipe(isFavorite: true),
                .stubRecipe(isFavorite: false)
            ],
            showFavorites: false
        )
        
        // Then
        assertSnapshot(of: viewController, as: .image)
    }
    
}

// MARK: - Helpers
extension RecipesListSnapshotTests {
    private func createView(
        with recipes: [RecipeUIState],
        showFavorites: Bool = true
    ) -> UIViewController {
        let state = RecipesListUIState.stubContent(recipes: recipes)
        
        let view = RecipesListView<Text>(
            uiState: state,
            recipeDetailsView: { _ in Text("Recipe details view") }
        )
        view.showFavorites = showFavorites
        
        return UIHostingController(rootView: view)
    }
}
