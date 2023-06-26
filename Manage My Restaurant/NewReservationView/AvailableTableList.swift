//
//  AvailableTableList.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 05/06/2023.
//

import SwiftUI
import CoreData

struct AvailableTableList: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @EnvironmentObject private var userSettings: UserSettings
    
    @Binding var activeTable: Int
    @Binding var reservationDate: Date
    
    
    
    var body: some View {
        
        FetchedObjects(predicate: buildTablePredicate(), sortDescriptors: buildTableSortDescriptor()) {
            (tables: [Table]) in
            
            
//            TODO: Rewrite this part to fetch within a fetch
            List {
                
                ForEach(tables) { table in
            
                        HStack {
                            
                            Image(systemName: activeTable == Int(table.tableNumber) ?  "circle.inset.filled" : "circle" )
                                .padding(.trailing, 5)
                            
                            Text("Table: \(table.tableNumber)")
                                .padding(.trailing, 5)
                            
                            ScrollView(.horizontal) {
                                
                                FetchedObjects(predicate: buildGuestPredicate(table), sortDescriptors: buildGuestSortDescriptor()) {
                                (guests: [Guest]) in

                                HStack {
                                    
                                    ForEach(guests) { guest in

                                        Button(action: {
                                            
                                            
                                        }, label: {
                                            
                                            Text(guest.date?.formatted(date: .omitted, time: .shortened) ?? "Not available")
                                            
                                        })
                                        .padding(5)

                                    }
                                    }
                                }
                            
                            }
                        
                        }
                    .onTapGesture {
                        
                        activeTable = Int(table.tableNumber)
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

extension AvailableTableList {
    
    func buildTablePredicate() -> NSPredicate {
        
//        TODO: How to predicate tables wrt reserved dates
//
        let entityPredicate = NSPredicate(format: "entity = %@", Table.entity())
        
        return entityPredicate

    }
    
    func buildTableSortDescriptor() -> [NSSortDescriptor] {
        
        
       return [NSSortDescriptor(keyPath: \Table.tableNumber, ascending: true)]
        
    }
    
    func buildGuestPredicate(_ table:Table) -> NSPredicate {
        
        let startingDate = Date(timeInterval: -7199, since: reservationDate)
       
        
        
        let endingDate = Date(timeInterval: 7199, since: reservationDate)
        
        let startingTimePredicate = NSPredicate(format: "date => %@ ", startingDate as NSDate)
        let endingTimePredicate = NSPredicate(format: "date =< %@", endingDate as NSDate)
        
        let guestPredicate = NSPredicate(format: "toTable.tableNumber = %i", table.tableNumber)
        
        let timeCompoundPredicate = NSCompoundPredicate(type: .not, subpredicates: [startingTimePredicate, endingTimePredicate])
        
        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [guestPredicate ,timeCompoundPredicate])
         
        return compoundPredicate
    }
    
    func buildGuestSortDescriptor() -> [NSSortDescriptor] {
        
        return [NSSortDescriptor(keyPath: \Guest.date, ascending: true)]
        
    }
    

    
    
    
}

struct AvailableTableList_Previews: PreviewProvider {
    static var previews: some View {
        AvailableTableList(activeTable: .constant(1), reservationDate: .constant(.now))
    }
}
