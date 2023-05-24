//
//  DayModel.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 10/04/2023.
//

import Foundation

struct Day: Identifiable, Codable {
    
    var id = UUID()
    var day: String
    var isOpen = true
    
    enum DaysOfTheWeek: String {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
//    TODO: Implement safety check for days of the week
    init(day: DaysOfTheWeek) {
        self.day = day.rawValue
    }
}
