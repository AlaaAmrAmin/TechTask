import Foundation

protocol JSONStorage<Entity>: Actor {
    associatedtype Entity: Codable
    
    func write(_ data: Entity) throws(JSONFileError)
    func read() throws(JSONFileError) -> Entity
    func deleteFile() throws(JSONFileError)
}

actor JSONFileClient<Entity: Codable>: JSONStorage {
    private let fileName: String
    private let fileManager: FileManager
    private var fileURL: URL? {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName)
    }

    init(fileName: String, fileManager: FileManager) {
        self.fileName = fileName
        self.fileManager = fileManager
    }

    func write(_ data: Entity) throws(JSONFileError) {
        guard let fileURL = fileURL else {
            throw .invalidPath
        }
        
        do {
            let jsonData = try JSONEncoder().encode(data)
            try jsonData.write(to: fileURL, options: .atomic)
        } catch {
            throw .writingFailed(error)
        }
    }

    func read() throws(JSONFileError) -> Entity {
        guard let fileURL = fileURL else {
            throw .invalidPath
        }
        
        guard fileManager.fileExists(atPath: fileURL.path) else {
            throw .fileDoesNotExist
        }
        
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let decodedData = try JSONDecoder().decode(Entity.self, from: jsonData)
            return decodedData
        } catch {
            throw .readingFailed(error)
        }
    }

    func deleteFile() throws(JSONFileError) {
        guard let fileURL = fileURL else {
            throw .invalidPath
        }
        
        do {
            try fileManager.removeItem(at: fileURL)
        } catch {
            throw .fileDeletionFailed(error)
        }
    }
}

enum JSONFileError: Error {
    case invalidPath
    case fileDoesNotExist
    case writingFailed(Error)
    case readingFailed(Error)
    case fileDeletionFailed(Error)
}
