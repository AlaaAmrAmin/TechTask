import XCTest
@testable import Rightmove

@MainActor
final class RecipesListViewModelTests: XCTestCase {
    private var sut: RecipesListViewModel!
    private var spyBuilder: SpyRecipesListUIStateBuilder!
    
    override func setUp() async throws {
        try await super.setUp()
        
        spyBuilder = SpyRecipesListUIStateBuilder()
        sut = RecipesListViewModel(uiStateBuilder: spyBuilder)
    }
    
    override func tearDown() async throws {
        sut = nil
        spyBuilder = nil
        
        try await super.tearDown()
    }
    
    func test_whenInitIsTriggered_thenUIStateIsLoading() {
        // Given
        spyBuilder.reset()
        let stubbedState = RecipesListUIState.stubLoading()
        spyBuilder.stubbedUIState = stubbedState
        
        // When
        let sut = RecipesListViewModel(uiStateBuilder: spyBuilder)
        
        // Then
        XCTAssertEqual(spyBuilder.calls.count, 1)
        XCTAssertEqual(spyBuilder.calls.first, .buildLoading)
        XCTAssertEqual(sut.uiState, stubbedState)
    }
    
    func test_whenRecipesFetched_thenUIStateIsContent() async {
        // Given
        let stubbedState = RecipesListUIState.stubContent(recipes: [.stubRecipe()])
        spyBuilder.stubbedUIState = stubbedState
        let recipes = [Recipes.RecipeOverview.stub()]
        
        // When
        await sut.recipesListDidFetch(recipes)
        
        // Then
        XCTAssertEqual(spyBuilder.calls.count, 2) // Initial loading + content build
        if case .buildContent(let passedRecipes) = spyBuilder.calls[1] {
            XCTAssertEqual(passedRecipes, recipes)
        } else {
            XCTFail("Expected buildContent call")
        }
        XCTAssertEqual(sut.uiState, stubbedState)
    }
    
    func test_whenRecipesFetchFails_thenUIStateIsError() async {
        // Given
        let stubbedState = RecipesListUIState.stubError()
        spyBuilder.stubbedUIState = stubbedState
        
        // When
        await sut.recipesListDidFail(with: NSError(domain: "", code: 0))
        
        // Then
        XCTAssertEqual(spyBuilder.calls.count, 2) // loading + error build
        XCTAssertEqual(spyBuilder.calls[1], .buildError)
        XCTAssertEqual(sut.uiState, stubbedState)
    }
    
    func test_whenRecipeDidFavorite_thenUpdatesStateWithFavoriteStatus() async {
        // Given
        let stubbedState = RecipesListUIState.stubContent(recipes: [])
        spyBuilder.stubbedUIState = stubbedState
        let recipeID = 12
        
        // When
        await sut.recipeDidFavorite(recipeID: recipeID)
        
        // Then
        XCTAssertEqual(spyBuilder.calls.count, 2) // Initial loading + favorite update
        if case let .buildUpdateWithUpdatedFavoriteStatus(currentState, passedRecipeID, isFavorite) = spyBuilder.calls[1] {
            XCTAssertEqual(currentState, stubbedState)
            XCTAssertEqual(passedRecipeID, recipeID)
            XCTAssertTrue(isFavorite)
        } else {
            XCTFail("Expected buildUpdateWithUpdatedFavoriteStatus call")
        }
        XCTAssertEqual(sut.uiState, stubbedState)
    }
    
    func test_whenRecipeDidUnfavorite_thenUpdatesStateWithUnfavoriteStatus() async {
        // Given
        let stubbedState = RecipesListUIState.stubContent(recipes: [])
        spyBuilder.stubbedUIState = stubbedState
        let recipeID = 12
        
        // When
        await sut.recipeDidUnfavorite(recipeID: recipeID)
        
        // Then
        XCTAssertEqual(spyBuilder.calls.count, 2) // Initial loading + unfavorite update
        if case .buildUpdateWithUpdatedFavoriteStatus(let currentState, let passedRecipeID, let isFavorite) = spyBuilder.calls[1] {
            XCTAssertEqual(currentState, stubbedState)
            XCTAssertEqual(passedRecipeID, recipeID)
            XCTAssertFalse(isFavorite)
        } else {
            XCTFail("Expected buildUpdateWithUpdatedFavoriteStatus call")
        }
        XCTAssertEqual(sut.uiState, stubbedState)
    }
}

// MARK: - Helpers

extension Recipes.RecipeOverview {
    static func stub(
        id: Int = 1,
        thumbnailURL: URL? = nil,
        name: String = "Test Recipe",
        description: String = "Test Description",
        positiveRatingPercentage: Double = 80
    ) -> Recipes.RecipeOverview {
        return .init(
            id: id,
            thumbnailURL: thumbnailURL,
            name: name,
            description: description,
            positiveRatingPercentage: positiveRatingPercentage,
            cookingTime: Time(hours: 1, minutes: 30)
        )
    }
}
