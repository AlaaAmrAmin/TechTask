import Foundation

protocol ResponseDomainMapping<Response, Domain>: Sendable {
    associatedtype Response
    associatedtype Domain
    
    func map(_ dto: Response) -> Domain
}

typealias ResponseRatingMapping = ResponseDomainMapping<RecipeDTO.RatingDTO, Double>
typealias ResponseTimeMapping = ResponseDomainMapping<Int, Time>
typealias ResponseInstructionsMapping = ResponseDomainMapping<[RecipeDTO.InstructionDTO], [Recipe.Instruction]>
typealias ResponseIngredientsMapping = ResponseDomainMapping<[RecipeDTO.SectionDTO.ComponentDTO], [Recipe.Ingredient]>
typealias ResponseNutritionMapping = ResponseDomainMapping<RecipeDTO.NutritionDTO, Recipe.Nutrition>
