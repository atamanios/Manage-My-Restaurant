//
//  DayModel.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 10/04/2023.
//

import Foundation

struct Day: Identifiable, Codable, Equatable, Hashable {
    
    var id = UUID()
    var day: String
    var isOpen: Bool
    
    enum DaysOfTheWeek: String {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
//    TODO: Implement safety check for days of the week
    init(day: DaysOfTheWeek) {
        self.day = day.rawValue
        self.isOpen = true
    }
    
    static func == (lhs: Day, rhs: Day) -> Bool {
        
        return lhs.day == rhs.day && lhs.isOpen == rhs.isOpen
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(day)
    }
}
