struct TimeResponseMapper: ResponseDomainMapping {
    func map(_ minutes: String) -> Time? {
        guard let minutes = Int(minutes) else {
            return nil
        }
        
        return Time(
            hours: minutes / 60,
            minutes: minutes % 60
        )
    }
}
