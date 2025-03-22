import Foundation

protocol RemoteDataLoader {
    var requestConstructor: RequestConstructing { get }
    var client: Networking { get }
    
    func fetchData<Response: Decodable>(using configuration: RequestConfiguration) async throws -> Response
}

extension RemoteDataLoader {
    func fetchData<Response: Decodable>(using configuration: RequestConfiguration) async throws -> Response {
        let request = try requestConstructor.constructRequest(from: configuration)
        return try await client.startRequest(request)
    }
}
