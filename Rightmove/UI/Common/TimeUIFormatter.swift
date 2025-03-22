import Foundation

protocol TimeUIFormatting {
    func formatTime(_ time: Time) -> String?
}

struct TimeUIFormatter: TimeUIFormatting {
    func formatTime(_ time: Time) -> String? {
        let hours = time.hours == 1 ? Copy.hour : Copy.hours
        let minutes = time.minutes == 1 ? Copy.minute : Copy.minutes
        var formattedTimed = ""
        if time.hours > 0 {
            formattedTimed += "\(time.hours)\(hours)"
        }
        
        if time.minutes > 0 {
            if !formattedTimed.isEmpty {
                formattedTimed += " "
            }
            formattedTimed += "\(time.minutes)\(minutes)"
        }
        return formattedTimed.isEmpty ? nil : formattedTimed
    }
    
    enum Copy {
        static let hour: String = "hour"
        static let hours: String = "hours"
        static let minute: String = "minute"
        static let minutes: String = "minutes"
    }
}
