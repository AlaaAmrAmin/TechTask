//
//  File.swift
//  Rightmove
//
//  Created by Alaa Amin on 22/03/2025.
//


 private func formatTime(_ time: Time) -> String? {
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