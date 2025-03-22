struct TagsDTO: Decodable {
    let tags: [Tag]
    
    struct Tag: Decodable {
        let id: String
        let type: String
        let name: String
        let displayName: String
    }
    
    enum CodingKeys: String, CodingKey {
        case tags = "results"
    }
}
