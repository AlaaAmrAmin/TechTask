import Foundation

protocol TagsRemoteLoader: RemoteDataLoader {
    func fetchTags() async throws -> TagsDTO
}

struct TagsRepository: TagsRemoteLoader {
    let requestConstructor: any RequestConstructing
    let client: any Networking
    
    func fetchTags() async throws -> TagsDTO {
        let requestConfig = constructTagsListRequestConfig()
        return try await fetchData(using: requestConfig)
    }
}

private extension TagsRepository {
    typealias Endpoints = TastyAPIConfig.Endpoints
    
    func constructTagsListRequestConfig() -> RequestConfiguration {
        RequestConfiguration(
            path: Endpoints.TagsList.path,
            httpMethod: .get,
            headers: TastyAPIConfig.headers
        )
    }
}

private extension TastyAPIConfig {
    struct Endpoints {
        struct TagsList {
            static let path = "tags/list"
        }
    }
}
