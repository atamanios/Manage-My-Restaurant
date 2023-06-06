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
    
    @Binding var activeTable: Int
    
    var body: some View {
        
        FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptor()) {
            (tables: [Table]) in
            
            List {
                
                ForEach(tables) { table in
                    
                    let _ = print("The table is \(table.tableNumber) and \(table) ")
                    
                    HStack {
                        
                        Image(systemName: activeTable == Int(table.tableNumber) ?  "circle.inset.filled" : "circle" )
                            .padding(.trailing, 5)
                        
                        Text("Table: \(table.tableNumber)")
                            .padding(.trailing, 5)
                        
                        Text("Available Time Slots")
                        
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
    
    func buildPredicate() -> NSPredicate {
        
//        TODO: How to predicate tables wrt reserved dates
//
        let entityPredicate = NSPredicate(format: "entity = %@", Table.entity())
        
        return entityPredicate

    }
    
    func buildSortDescriptor() -> [NSSortDescriptor] {
        
        
       return [NSSortDescriptor(keyPath: \Table.tableNumber, ascending: true)]
        
    }
    
    
    
}

struct AvailableTableList_Previews: PreviewProvider {
    static var previews: some View {
        AvailableTableList(activeTable: .constant(1))
    }
}
