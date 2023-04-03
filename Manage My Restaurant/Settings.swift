//
//  Settings.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 03/04/2023.
//

import SwiftUI
import CoreData

struct Settings: View {
    var body: some View {
        VStack {
            
            Text("General Settings")
            
            Text("Does your restaurant have closed days?")
            
            Text("Restaurant open hours")
            
            Text("Standard allocated time for each reservation")
            
            Text("Number of Table")
            
            Text("Distribute these reservations to tables")
            
            Text("How far new reservations be allowed")
        
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
