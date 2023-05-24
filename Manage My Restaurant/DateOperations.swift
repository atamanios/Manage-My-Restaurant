//
//  DateOperations.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 15/04/2023.
//

import SwiftUI

struct DateOperations {
    
    var components = DateComponents()
    var now: Date
    var openingHour: Int
    var openingMinute: Int
    var closingHour: Int
    var closingMinute: Int
    
    init() {
        
        openingHour = 10
        openingMinute = 0
        closingHour = 22
        closingMinute = 0
        now = .now
    }
    
    
    func validateTiming(reservationTime: Date) -> Bool {
            
    
        
        
        
        return false
    }
    
    
    
}


