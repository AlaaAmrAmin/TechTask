import Foundation
import UIKit

class ImageDownloader {
    let client: APIClient
    
    private var cache = [String: UIImage]()
    
    init(client: APIClient) {
        self.client = client
    }
    
    func downloadImage(from url: URL) async throws -> UIImage? {
        guard cache[url.absoluteString] == nil else {
            return cache[url.absoluteString]
        }
        
        guard let data = try await client.downloadData(from: url) else { return nil }
        let image = UIImage(data: data)
        cache[url.absoluteString] = image
        return image
    }
}
