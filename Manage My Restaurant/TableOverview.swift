//
//  TableOverview.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 03/04/2023.
//

import SwiftUI
import CoreData

struct TableOverview: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            
            Text("Current Date")
            
            Text("Table Overview")
            
            Text("Occupancy")
            
        }
    }
}

struct TableOverview_Previews: PreviewProvider {
    static var previews: some View {
        TableOverview()
    }
}
