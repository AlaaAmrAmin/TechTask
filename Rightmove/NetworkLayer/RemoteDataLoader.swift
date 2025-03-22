import Foundation

protocol RemoteDataLoader {
    var requestBuilder: RequestBuilder { get }
    var requestConfiguration: RequestConfiguration { get}
    var client: APIClient { get }
    
    func fetchData<Response: Decodable>() async throws -> Response
}

extension RemoteDataProvider {
    func fetchData<Response: Decodable>() async throws -> Response {
        let request = try requestBuilder.constructRequest(from: requestConfiguration)
        return try await client.startRequest(request)
    }
}

//class RemoteService: DataFetcher {
//    let requestBuilder: RequestBuilder
//    let client: APIClient
//    
//    var requestConfiguration: RequestConfiguration? {
//        nil
//    }
//    
//    init(requestBuilder: RequestBuilder, client: APIClient) {
//        self.requestBuilder = requestBuilder
//        self.client = client
//    }
//    
//    func fetchData<Response: Decodable>() async throws -> Response {
//        guard let requestConfiguration = requestConfiguration else {
//            throw APIError.emptyRequestConfiguration
//        }
//        
//        let request = try requestBuilder.constructRequest(from: requestConfiguration)
//        return try await client.startRequest(request)
//    }
//}
