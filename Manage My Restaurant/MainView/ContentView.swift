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
    @EnvironmentObject private var userSettings: UserSettings
    
    @State private var day: Date = .now
    
    var body: some View {
        
        NavigationStack {
            
            TopSectionView(today: $day)
            
            TabView {
                
                TableListView(today: $day)
                    .tabItem {
                        Label("Tables", systemImage: "table.furniture")
                    }
                GuestListView(today: $day)
                    .tabItem {
                        Label("Guest List", systemImage: "person.3")
                    }
                AvailableTimeView(day: $day, numberOfGuest: 2)
                    .tabItem {
                        Label("New Reservation", systemImage: "rectangle.and.pencil.and.ellipsis")
                    }
            }
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
