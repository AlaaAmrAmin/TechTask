import Foundation

protocol RecipesRemoteLoader: RemoteDataLoader, Sendable {
    func fetchRecipes(withTags tags: [String], startingFrom itemNumber: Int) async throws -> RecipesDTO
    func fetchRecipe(with id: String) async throws -> RecipeDTO
}

struct RecipesRemoteRepository: RecipesRemoteLoader {
    let requestConstructor: any RequestConstructing
    let client: any Networking
    let pageSize: Int
    
    func fetchRecipes(withTags tags: [String], startingFrom itemNumber: Int) async throws -> RecipesDTO {
        let requestConfig = constructRecipesListRequestConfig(tags: tags, from: itemNumber)
        return try await fetchData(using: requestConfig)
    }
    
    func fetchRecipe(with id: String) async throws -> RecipeDTO {
        let requestConfig = constructRecipeInfoRequestConfig(recipeID: id)
        return try await fetchData(using: requestConfig)
    }
}

private extension RecipesRemoteRepository {
    typealias Endpoints = TastyAPIConfig.Endpoints
    
    func constructRecipesListRequestConfig(
        tags: [String],
        from: Int
    ) -> RequestConfiguration {
        var queryParameters: [String: String] = [
            Endpoints.RecipesList.QueryParameter.size.rawValue: String(pageSize),
            Endpoints.RecipesList.QueryParameter.from.rawValue: String(from)
        ]
        if !tags.isEmpty {
            queryParameters[Endpoints.RecipesList.QueryParameter.tags.rawValue] = tags.joined(separator: ",")
        }
        
        return RequestConfiguration(
            path: Endpoints.RecipesList.path,
            httpMethod: .get,
            queryParameters: queryParameters,
            headers: TastyAPIConfig.headers
        )
    }
    
    func constructRecipeInfoRequestConfig(recipeID: String) -> RequestConfiguration {
        RequestConfiguration(
            path: Endpoints.RecipeInfo.path,
            httpMethod: .get,
            queryParameters: [Endpoints.RecipeInfo.QueryParameter.id.rawValue: recipeID],
            headers: TastyAPIConfig.headers
        )
    }
}

private extension TastyAPIConfig {
    struct Endpoints {
        struct RecipesList {
            static let path = "recipes/list"
            
            enum QueryParameter: String {
                case size
                case from
                case tags
            }
        }
        
        struct RecipeInfo {
            static let path = "recipes/get-more-info"
            
            enum QueryParameter: String {
                case id
            }
        }
    }
}
