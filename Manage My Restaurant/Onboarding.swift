//
//  Onboarding.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 03/04/2023.
//

import SwiftUI

struct Onboarding: View {
    
    @State var nameOfRestaurant = ""
    @State var numberOfTables = 0
    @State var openDays: [String] = []
    @State var operatingHours: [String] = []
    
    
    var body: some View {
        VStack{
            
            Text("Name of the restaurant")
            
            Text("Upload restaurant logo")
            
            Text("Number of tables")
            
            Text("open days")
            
            Text("Operating Hours")
            
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
