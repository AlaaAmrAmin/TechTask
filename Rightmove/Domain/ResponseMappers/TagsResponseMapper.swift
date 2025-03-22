import Foundation

struct TagsResponseMapper: ResponseDomainMapping {
    func map(_ dto: TagsDTO) -> Tags {
        Tags(
            list: dto.tags.map { tagDTO in
                Tags.Tag(
                    id: tagDTO.id,
                    type: tagDTO.type,
                    name: tagDTO.name,
                    displayName: tagDTO.displayName
                )
            }
        )
    }
}

