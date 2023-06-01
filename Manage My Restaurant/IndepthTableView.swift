//
//  IndepthTableView.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 13/04/2023.
//

import SwiftUI

struct IndepthTableView: View {
    
    @ObservedObject var tableItem: Table
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                Text("Table Number: \(tableItem.tableNumber)")
                
                Text("Table Capacity: \(tableItem.seatingCapacity)")
                
            }
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptor()) { (guests:[Guest]) in
                
                List {
                    
                    ForEach(guests) { guest in
                        VStack {
                            Text("The guest name is \(guest.name ?? "unknown")")
                            
                            Text("The date is: \(guest.date?.formatted() ?? "unknown")")
                        }
                        .padding(2)
                    }
                }
            }
        }
    }
    
    func buildPredicate() -> NSPredicate {
        
//        let predicate = NSPredicate(format: "tableNumber = %@", tableItem.tableNumber as Int16 )
//        return predicate
        return NSPredicate(value: true)
    }
    
    func buildSortDescriptor() -> [NSSortDescriptor] {
        
        return [NSSortDescriptor(keyPath: \Guest.date, ascending: true)]
        
    }
    
}

struct IndepthTableView_Previews: PreviewProvider {
    static var previews: some View {
        IndepthTableView(tableItem: .init())
    }
}
