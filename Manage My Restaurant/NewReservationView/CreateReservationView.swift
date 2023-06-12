//
//  CreateReservationView.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 09/06/2023.
//

import SwiftUI

struct CreateReservationView: View {
    
    @State var reservationDate: Date = .now
    @State var numberOfGuest = 1
    
    var body: some View {
        
        NavigationStack {
           
            HStack {
                DatePicker(selection: $reservationDate,
                           in: Date(timeIntervalSinceNow: 3600)...Date(timeIntervalSinceNow: 7776000),
                           displayedComponents: .date,
                           label: {
                    Text("Choose Date")
                })
                
                Text("Guests:")
                
                Spacer()
                
                Picker("Number of Guest" ,selection: $numberOfGuest) {
                    ForEach(1...15, id: \.self) {
                        
                        Text("\($0)")
                    }
                }
                .pickerStyle(.menu)
            }
        }
    }
}

struct CreateReservationView_Previews: PreviewProvider {
    static var previews: some View {
        CreateReservationView()
    }
}
