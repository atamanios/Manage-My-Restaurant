//
//  TableListView.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 13/06/2023.
//

import SwiftUI

struct TableListView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var userSettings: UserSettings
    
    @Binding var today: Date
    
    var body: some View {
        
        VStack {
            
            ZStack {
                NavigationLink(destination: Snapshot()) { TableOverview() }.tint(.black)
            }
            Divider()
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptor()) { (tables: [Table]) in
                
                List {
                        
                        ForEach(tables) { table in
                            
                            ZStack {
                                NavigationLink(destination: IndepthTableView(tableItem: table)) { EmptyView() }.opacity(0.0)
                                
                                TableView(tableItem: table, date: $today)
                            }
                        }
                }
                .listStyle(.plain)
            
            }
            .onAppear{

                ContextOperations.checkAndRemoveDuplicateTables(viewContext)
            }
        }
        
        
    }
}
extension TableListView {
    
    func buildPredicate() -> NSPredicate {

        let entityPredicate = NSPredicate(format: "entity = %@", Table.entity())

        return entityPredicate
    }
    
    func buildSortDescriptor() -> [NSSortDescriptor] {
        
       return [NSSortDescriptor(keyPath: \Table.tableNumber, ascending: true)]
        
    }
}
