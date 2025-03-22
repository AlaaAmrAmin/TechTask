import Foundation

protocol Networking: Sendable {
    func startRequest<Model: Decodable>(_ request: URLRequest) async throws -> Model
    func download(from url: URL) async throws -> (Data, URLResponse)
}

struct APIClient: Networking {
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func startRequest<Model: Decodable>(_ request: URLRequest) async throws -> Model {
        let (data, _) = try await session.data(for: request, delegate: nil)
        let response = try JSONDecoder().decode(Model.self, from: data)
        return response
    }
    
    func download(from url: URL) async throws -> (Data, URLResponse) {
        return try await session.data(from: url, delegate: nil)
    }
}
