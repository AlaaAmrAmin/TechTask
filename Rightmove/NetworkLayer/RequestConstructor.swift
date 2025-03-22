import Foundation

protocol RequestConstructing: Sendable {
    func constructRequest(from configuration: RequestConfiguration) throws(RequestError) -> URLRequest
}

struct RequestConstructor: RequestConstructing {
    private let baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func constructRequest(from configuration: RequestConfiguration) throws(RequestError) -> URLRequest {
        switch configuration.httpMethod {
            case .get:
                return try constructGetRequest(from: configuration)
            default:
                // Not handled
                break
        }
        
        throw .unsupportedHTTPMethod
    }
    
    private func constructGetRequest(from configuration: RequestConfiguration) throws(RequestError) -> URLRequest {
        var components = URLComponents(string: "\(baseURL)\(configuration.path)")
        if let queryParameters = configuration.queryParameters {
            components?.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components?.url  else {
            throw .invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = configuration.httpMethod.rawValue
        
        for (header, value) in configuration.headers {
            request.setValue(value, forHTTPHeaderField: header)
        }
        
        return request
    }
}

enum RequestError: Error {
    case invalidURL
    case unsupportedHTTPMethod
}
