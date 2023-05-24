//
//  Manage_My_RestaurantApp.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 02/04/2023.
//

import SwiftUI


@main
struct Manage_My_RestaurantApp: App {
    let persistenceController = PersistenceController.shared
        
    var body: some Scene {
        WindowGroup {
            Onboarding()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                

        }
    }
}
