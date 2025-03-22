import Foundation

struct RequestConfiguration {
    let path: String
    let httpMethod: HTTPMethod
    let queryParameters: [String: String]?
    let bodyParameters: [String: Any]?
    let headers: [String: String]
    
    init(
        path: String,
        httpMethod: RequestConfiguration.HTTPMethod,
        queryParameters: [String : String]? = nil,
        bodyParameters: [String : Any]? = nil,
        headers: [String : String]
    ) {
        self.path = path
        self.httpMethod = httpMethod
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
        self.headers = headers
    }
}

extension RequestConfiguration {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}
