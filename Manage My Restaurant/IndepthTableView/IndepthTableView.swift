//
//  IndepthTableView.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 13/04/2023.
//

import SwiftUI
import CoreData

struct IndepthTableView: View {
    
    @ObservedObject var tableItem: Table
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                Text("Table Number: \(tableItem.tableNumber)")
                
                Text("Table Capacity: \(tableItem.seatingCapacity)")
                
            }
            
                List {
                    
                    ForEach(guests()) { guest in
                        
                        VStack {
                            Text("The guest name is \(guest.name ?? "unknown")")
                            
                            Text("The date is: \(guest.date?.formatted() ?? "unknown")")
                            
                            Text("The table number is: \(guest.toTable?.tableNumber ?? Int64(0))")
                        }
                        .padding(2)
                    }
                }
            }
//        }
    }
}

extension IndepthTableView {
    
    func guests() -> [Guest] {
        
        let request: NSFetchRequest<Guest> = Guest.fetchRequest()
        request.predicate = buildPredicate()
        request.sortDescriptors = buildSortDescriptor()
        
        var fetchedGuests: [Guest] = []
        
        do {
            fetchedGuests = try PersistenceController.shared.container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching guests \(error.localizedDescription)")
        }
        
        
        return fetchedGuests
    }
    
    func buildPredicate() -> NSPredicate {
        
        var predicate: NSPredicate
        
        predicate = NSPredicate(format: "toTable.tableNumber = %i", tableItem.tableNumber )
        
        return predicate

        
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
