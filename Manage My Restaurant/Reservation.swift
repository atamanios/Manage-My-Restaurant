//
//  Reservation.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 03/04/2023.
//

import SwiftUI
import CoreData

struct Reservation: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack{
            
            Text("Guest Name")
            
            Text("Number of guests")
            
            Text("Date")
            
            Text("Phone number")
            
            Text("Suggested Table")
            
            Text("Allocated table")
        
        }
    }
}

struct Reservation_Previews: PreviewProvider {
    static var previews: some View {
        Reservation()
    }
}
