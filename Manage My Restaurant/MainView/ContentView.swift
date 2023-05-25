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
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Tables.tableNumber, ascending: true)],
        animation: .default)
    
    private var tables: FetchedResults<Tables>
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                ZStack {
                    NavigationLink(destination: Snapshot()) { TableOverview() }.tint(.black)
                }
                Divider()
                
                List(tables) { table in
                        
                    ZStack {
                        NavigationLink(destination: IndepthTableView(tableItem: table)) { EmptyView() }.opacity(0.0)
                        
                        TableView(tableItem: table)
                    }
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

            ContextOperations.batchDelete("Tables", viewContext)

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
    
    

}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewContext: Environment(\.managedObjectContext))
    }
}
