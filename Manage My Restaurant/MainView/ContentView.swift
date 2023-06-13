//
//  ContentView.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 02/04/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var userSettings: UserSettings
    
    @State private var today: Date = .now
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        NavigationStack {
            
            TabView {
                
                TableListView(today: $today)
                    .tabItem {
                        Label("Tables", systemImage: "table.furniture")
                    }
                
                GuestListView(today: $today)
                    .tabItem {
                        Label("Guest List", systemImage: "person.3")
                    }
                
                
                CreateNewReservation()
                    .tabItem {
                        Label("New Reservation", systemImage: "rectangle.and.pencil.and.ellipsis")
                    }
                
                
                
                
            }
            
            
            
            //            VStack {
            //
            //                ZStack {
            //                    NavigationLink(destination: Snapshot()) { TableOverview() }.tint(.black)
            //                }
            //                Divider()
            //
            //                FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptor()) { (tables: [Table]) in
            //
            //                    List {
            //
            //                            ForEach(tables) { table in
            //
            //                                ZStack {
            //                                    NavigationLink(destination: IndepthTableView(tableItem: table)) { EmptyView() }.opacity(0.0)
            //
            //                                    TableView(tableItem: table, date: $today)
            //                                }
            //                            }
            //                    }
            //                    .listStyle(.plain)
            //
            //                }
            //                .onAppear{
            //
            //                    ContextOperations.checkAndRemoveDuplicateTables(viewContext)
            //                }
//        }
            .toolbar {
                
                HeaderView()
                
            }
        }
    }
}

extension ContentView {
    
    var createNewReservation: some View {
        
        NavigationLink(destination: CreateNewReservation()) {
            
            Text("Create New Reservation")
            
        }.buttonStyle(.borderedProminent)
    }
    
    func buildPredicate() -> NSPredicate {

        let entityPredicate = NSPredicate(format: "entity = %@", Table.entity())

        return entityPredicate
    }
    
    func buildSortDescriptor() -> [NSSortDescriptor] {
        
       return [NSSortDescriptor(keyPath: \Table.tableNumber, ascending: true)]
        
    }
    
    func deleteItem (at offsets: IndexSet) {
        
//       TODO: Impelemt a delete method for list swipes
    
        
//        ContextOperations.delete(at: offsets, fetchResult: FetchedResults<NSManagedObject>, viewContex: viewContext)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewContext: Environment(\.managedObjectContext))
    }
}
