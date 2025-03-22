struct Tags {
    let list: [Tag]
}

extension Tags {
    struct Tag {
        let id: String
        let type: String
        let name: String
        let displayName: String
    }
}
