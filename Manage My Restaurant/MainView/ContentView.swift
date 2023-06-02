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
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        NavigationStack {
            
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
                                
                                TableView(tableItem: table)
                            }
                        }
                        .onDelete(perform: deleteItem)
                        
                    }
                }
                .onAppear{

                    ContextOperations.checkAndRemoveDuplicateTables(viewContext)

                }
                .listStyle(.plain)
            }
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    settings
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    delete
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    batchCreate
                }
                
                ToolbarItem(placement: .bottomBar) {
                    
                   createNewReservation
                }
                
                ToolbarItem(placement: .principal) {
                    
                    Image(systemName: "apple.logo")
                    
                }
            }
        }
    }
}

extension ContentView {
    
    var settings: some View {
        
        NavigationLink {
            
            Settings().environmentObject(userSettings)
            
        } label: {
            
            Image(systemName: "slider.horizontal.3")
                .font(.title3)
        }
    }
    
    var delete: some View {

        Button (action: {
            ContextOperations.batchDelete("Guest", viewContext)
            ContextOperations.batchDelete("Table", viewContext)

        }, label: {
            Image(systemName: "xmark.bin")
        } )
    }
    
    var batchCreate: some View {
        
        Button( action: {
            
            ContextOperations.batchCreate(viewContext, 10)
            
        }, label: {
            
            Image(systemName: "plus.diamond")
        
        })
        
    }
    
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
