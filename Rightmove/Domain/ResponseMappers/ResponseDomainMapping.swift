import Foundation

protocol ResponseDomainMapping<Response, Domain> {
    associatedtype Response
    associatedtype Domain
    
    func map(_ dto: Response) -> Domain
}
