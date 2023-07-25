//
//  Settings.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 03/04/2023.
//

import SwiftUI
import CoreData

struct Settings: View {
    
    

    @EnvironmentObject private var userSettings: UserSettings
    
    var body: some View {
        
        enteredDetails
    }
}

extension Settings {
    
    private var enteredDetails: some View {
        
        List {
            
            Text("\(userSettings.nameOfTheRestaurant)")
            
            HStack {

                Text("Open Days: ")

                ScrollView(.horizontal){
                    ForEach(userSettings.openDays.filter { $0.isOpen }) { item in

                        Text(item.day)
                            .padding(.horizontal, 1)
                            .bold()
                    }
                }
            }
            
            HStack{
                
                Text("Opening Hours: ")
//                Text("\(userSettings.openingHours.hour!.formatted()):\(userSettings.openingHours.minute!.formatted())")
                Text(userSettings.openingHours.hourAndMinuteDisplay())
            }
            
            HStack {
                
                Text("Closing Hours: ")
//                Text("\(userSettings.closingHours.hour!.formatted()):\(userSettings.closingHours.minute!.formatted())")
                Text(userSettings.closingHours.hourAndMinuteDisplay())
            }
        }
        .listStyle(.plain)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
