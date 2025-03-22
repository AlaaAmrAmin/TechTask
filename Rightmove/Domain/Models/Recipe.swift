//
//  RecipeDTO.swift
//  Rightmove
//
//  Created by Alaa Amin on 20/03/2025.
//


struct RecipeDTO: Decodable {
    let thumbnailURL: String?
    let name: String
    let description: String
    let rating: RecipeRatingDTO?
    let prepTimeInMinutes: String?
    let cookingTimeInMinutes: String?
    let instructions: [InstructionDTO]
    let sections: [SectionDTO]
    let nutrition: NutritionDTO?
    
    enum CodingKeys: String, CodingKey {
        case thumbnailURL = "thumbnail_url"
        case name
        case description
        case rating = "user_ratings"
        case prepTimeInMinutes = "prep_time_minutes"
        case cookingTimeInMinutes = "total_time_minutes"
        case instructions
        case sections
        case nutrition
    }
}

extension RecipeDTO {
    struct RecipeRatingDTO: Decodable {
        let negativeCount: Int
        let positiveCount: Int
        
        enum CodingKeys: String, CodingKey {
            case negativeCount = "count_negative"
            case positiveCount = "count_positive"
        }
    }
}

extension RecipeDTO {
    struct InstructionDTO: Decodable {
        let description: String
        let position: Int
        
        enum CodingKeys: String, CodingKey {
            case description = "display_text"
            case position
        }
    }
}

extension RecipeDTO {
    struct NutritionDTO: Decodable {
        let calories: Int
        let carbohydrates: Int
        let fat: Int
        let fiber: Int
        let protein: Int
        let sugar: Int
    }
}

extension RecipeDTO {
    struct SectionDTO: Codable {
        let components: [ComponentDTO]
        
        struct ComponentDTO: Codable {
            let description: String
            let position: String
            
            enum CodingKeys: String, CodingKey {
                case description = "raw_text"
                case position
            }
        }
    }
}
