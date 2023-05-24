//
//  TableView.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 13/04/2023.
//

import SwiftUI

struct TableView: View {
    
    @ObservedObject var tableItem: Tables
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Guest.date, ascending: true)],
//        animation: .default)
    
//    private var guests: FetchedResults<Guest>
//
//    init(withTables table: Tables) {
//        self.tableItem = table
//
//        _guests = FetchRequest(entity: Guest.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Guest.name, ascending: true)], predicate: NSPredicate(format: "table == %@", table))
//
//    }
    
    var body: some View {
        NavigationStack {
            VStack{
                
                HStack {
                    
                    Text("Table Number: \(tableItem.tableNumber)")
                    
                    Spacer()
                    
                    Text("Table Capacity: \(tableItem.seatingCapacity)")
                    
                }.padding(.vertical)
                
                ScrollView(.horizontal) {
                
                    HStack {
//                        ForEach() here
                        Text("Reserved Slot")
                    }
                }
            }
            .padding()
            .frame(height:100)
        }
    }
    
    func predicate () -> NSPredicate {
     
        let tableNumber = tableItem.tableNumber
        
        return NSPredicate(format: "tableNumber == %@", tableNumber)
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView(tableItem: .init())
    }
}
