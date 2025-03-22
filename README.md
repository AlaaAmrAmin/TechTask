# Rightmove Recipe App

A SwiftUI-based iOS application that showcases recipes from the Tasty API, with features for viewing recipe details and managing favorites.

## Architecture

The project follows Clean Architecture principles with MVVM pattern for the presentation layer, utilizing Swift's modern concurrency features (async/await). Here's a breakdown of the main components:

### 1. UI Layer (Presentation)
- **MVVM Pattern**
  - Views (SwiftUI)
  - ViewModels (ObservableObject)
  - UIState builders for immutable state management

### 2. Domain Layer
- **Models**
  - Core business models (Recipe, Recipes)
  - Independent of external frameworks
- **Mappers**
  - Entity to Domain model conversion and vise versa.
  - Remote to Domain model conversion
- **Use Cases**
  - Business logic implementation
  - Fetch data from remote and local reposiotries
  - Protocol-based for dependency inversion

### 3. Data Layer
- **Remote**
  - API client for Tasty API integration
  - Remote data models and repositories
- **Local**
  - JSON-based persistence (to speed up developement)
  - Local data models and repositories

 **Notes:**
 - I couldn’t find the documentation for the APIs responses’ contracts, so I checked the sample responses provided and made assumptions about whether the properties are mandatory or not.
 - Some areas are not 100% concurrency-safe and need a bit more work. I have added comments to them in the code. But they should not cause any data races with the current scope and implementation.

### 4. Infrastructure
- **NetworkLayer**
  - Generic API client
  - Request configuration and construction
- **LocalStorageLayer**
  - JSON file client for local storage

## Key Features

1. **Recipe List**
   - Display of remote recipes
   - Favorites section
   - Toggle favorites visibility

2. **Recipe Details**
   - Detailed recipe information
   - Favorite/Unfavorite functionality

 **UI Notes:**
 - Recipes images are not cached.
 - Failure to favorite/unfavorite a recipe is not handled.
 - All errors, from remote or cache, are treated the same.

## Testing

The project includes a smaple of:
- 1 Unit-test file
- 1 Snapshot-test file

The sample consists of only one file per testing approach due to time constraints, and no UI tests were included for the same reason.

## Dependencies

- **SnapshotTesting**: For UI component testing
