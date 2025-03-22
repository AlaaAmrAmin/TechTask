struct TimeResponseMapper: ResponseDomainMapping {
    func map(_ minutes: Int) -> Time {
        return Time(
            hours: minutes / 60,
            minutes: minutes % 60
        )
    }
}
