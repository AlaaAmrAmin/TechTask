//
//  TagsDTO.swift
//  Rightmove
//
//  Created by Alaa Amin on 19/03/2025.
//


struct TagsDTO: Decodable {
    let tags: [TagDTO]
    
    enum CodingKeys: String, CodingKey {
        case tags = "results"
    }
}

extension TagsDTO {
    struct TagDTO: Decodable {
        let id: String
        let type: String
        let name: String
        let displayName: String
    }
}
