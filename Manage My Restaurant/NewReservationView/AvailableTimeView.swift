//
//  AvailableTimeView.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 15/06/2023.
//

import SwiftUI
import CoreData

struct AvailableTimeView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject private var userSettings: UserSettings

    @Binding var day: Date
    @State var numberOfGuest: Int
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
            
                    LazyVGrid(columns: columns) {
                        
                        ForEach(intervaledWorkingHours(), id:\.self) { mark in

                            Text(mark.formatted(date: .omitted, time: .shortened))

                    }
                }
            }
        }
    }
}

extension AvailableTimeView {
    
    func buildPredicate(_ time: Date) -> NSPredicate {
        
        var openingHour = {
         
            var date = Calendar.current.dateComponents([.day, .month, .year], from: day)
            date.hour = userSettings.openingHours.hour
            date.minute = userSettings.openingHours.minute
            
            var returnedOpeningHour = Calendar.current.date(from: date)!
            
            return returnedOpeningHour as NSDate
           
        }
        
        var closingHour = {
            
            var date = Calendar.current.dateComponents([.day, .month, .year], from: day)
            date.hour = userSettings.closingHours.hour
            date.minute = userSettings.closingHours.minute
    
            var returnedClosingHour = Calendar.current.date(from: date)!
            
            return returnedClosingHour as NSDate
        }
        
        let workingHoursPredicate = NSPredicate(format: "date > %@ AND date < %@" , openingHour(), closingHour())
        
        let reservationTimePredicate = NSPredicate(format: "NOT date >  %@ AND NOT date < %@", NSDate(timeInterval: -7199, since: time), NSDate(timeInterval: 7199, since: time))
        
        let entityPredicate = NSPredicate(format: "entity = %@", Table.entity())
        
        let compoundPredicate =  NSCompoundPredicate(type: .and, subpredicates: [workingHoursPredicate, reservationTimePredicate, entityPredicate])
        
        return compoundPredicate
    }
    
    func buildSortDescriptor() -> [NSSortDescriptor] {
        
        let sortDescriptor = NSSortDescriptor(keyPath: \Table.tableNumber, ascending: true)
     
        return [sortDescriptor]
    }
    
    func intervaledWorkingHours() -> [Date] {
        
//        TODO: make interval with hourly stride and upon tapping show popup page with 15 minutes interval options
//        TODO: Interval cannot be negative, add a day to closinghour if the hour is earlier than opening hour
        
        var openingHour = {
            
            var dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: day)
            dateComponents.hour = userSettings.openingHours.hour
            dateComponents.minute = userSettings.openingHours.minute
            
            return Calendar.current.date(from: dateComponents)!
            
        }
        
        var closingHour = {
            
            var dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: day)
            dateComponents.hour = userSettings.closingHours.hour
            dateComponents.minute = userSettings.closingHours.minute
            
            return Calendar.current.date(from: dateComponents)!
            
        }
        
        let duration = DateInterval(start: openingHour(), end: closingHour()).duration
        
        var arr: [Date] = []
        
        for i in stride(from: 0, to: Int(duration), by: 900) {
            
            let date = Date(timeInterval: Double(i), since: openingHour())
            
            arr.append(date)
            
        }
    
        print(arr.first?.formatted())
        return arr
    }
    
    

}

//struct AvailableTimeView_Previews: PreviewProvider {
//    static var previews: some View {
//        AvailableTimeView()
//    }
//}
