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
    @EnvironmentObject private var userSettings: UserSettings
    
    let day = Date.now
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Text(userSettings.nameOfTheRestaurant.capitalized)
                
                Text(day.formatted(date: .abbreviated, time: .shortened))
                
            }
            
            Text("Occupancy").font(.title3)

        }
    }
}

struct TableOverview_Previews: PreviewProvider {
    static var previews: some View {
        TableOverview()
    }
}
