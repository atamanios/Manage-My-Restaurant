//
//  HeaderView.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 13/06/2023.
//

import SwiftUI
import CoreData

struct HeaderView: ToolbarContent {
    
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject private var userSettings: UserSettings
    
    
    var body: some ToolbarContent {
        
        ToolbarItem(placement: .navigationBarTrailing) {
            settings
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            delete
        }
        
        ToolbarItem(placement: .navigationBarLeading) {
            batchCreate
        }
        
        ToolbarItem(placement: .principal) {

            Image("Company Logo")
                .resizable()
                .scaledToFit()
                .padding(1)
                
        }
    }
}

extension HeaderView {
    
    var settings: some View {
        
        NavigationLink {
            
            Settings()
            
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
            
            ContextOperations.batchCreate(viewContext, 5)
            
        }, label: {
            
            Image(systemName: "plus.diamond")
        
        })
    }
}


