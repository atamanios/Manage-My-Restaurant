//
//  ContentView.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 02/04/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    //TODO: Implement Cloudkit for reservation data
    
    //    @FetchRequest(
    //        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    //        animation: .default)
    
//    private var items: FetchedResults<Item>
    
    var body: some View {
        
        Text("Hello World")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
