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
    @Binding var numberOfGuest: Int
    
    let columns = [
        GridItem(.flexible()),
//        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var timeList = [Date]()
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                LazyVGrid(columns: columns) {
                    
                    ForEach($timeList, id:\.self) { $mark in
                        
                        FetchedObjects(predicate: buildPredicate(mark, numberOfGuest), sortDescriptors: buildSortDescriptor()) { (tables:[Table]) in
                            
                            NavigationLink(destination: CreateNewReservation(reservationDate: $mark)) {
                                
                                HStack {
                                    
                                    Text(mark.formatted(date: .omitted, time: .shortened))
                                        .padding(.horizontal, 5)
                                        .frame(width: 100)
                                    
                                        .padding(.horizontal, 2)
                                    
                                    Text("\(tables.count)")
                                    
                                }
                                
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    
                }
            }
        }
        .onAppear {
//            TODO: PAge doesnt refresh when date changes
            timeList = intervaledWorkingHours()

        }
        
        .onChange(of: day) { _ in
            timeList = intervaledWorkingHours()
        }
    }
        
}

extension AvailableTimeView {
    
    func buildPredicate(_ time: Date, _ seatingCapacity: Int) -> NSPredicate {
        
        let entityPredicate = NSPredicate(format: "entity = %@", Table.entity())
        
        let tableCapacityPredicate = NSPredicate(format: "seatingCapacity => %i", Int64(seatingCapacity))
        
        let timePredicate = NSPredicate(format: "ANY toGuest.date > %@ AND ANY toGuest.date < %@" , NSDate(timeInterval: -7199, since: time), NSDate(timeInterval: 7199, since: time))
        
        let compoundTablePredicate =  NSCompoundPredicate(type: .and, subpredicates: [entityPredicate, tableCapacityPredicate])
        
        let compoundTimePredicate = NSCompoundPredicate(type: .not, subpredicates: [timePredicate])
    
        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [compoundTimePredicate, compoundTablePredicate])
        
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
    
        return arr
    }
    

    
}

//struct AvailableTimeView_Previews: PreviewProvider {
//    static var previews: some View {
//        AvailableTimeView()
//    }
//}
