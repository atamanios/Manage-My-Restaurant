//
//  NewReservationForm.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 05/06/2023.
//

import SwiftUI

struct NewReservationForm: View {
    
    @Binding var guestName: String
    @Binding var guestPhoneNumber: String
    @Binding var guestEmail: String
    @Binding var numberOfGuest: Int
    @Binding var reservationDate: Date
    
    var body: some View {
        
        VStack {
            
            HStack {
                Text("Enter Guest Name")
                Spacer()
            }
            
            TextField("Guest Name", text: $guestName)
                .padding(8)
                .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(lineWidth: 1).foregroundColor(.gray))
                .padding(.bottom, 10)
            
            HStack{
                Text("Enter Guest Phone Number")
                Spacer()
            }
            
            TextField("Guest Phone Number", text: $guestPhoneNumber)
                .padding(8)
                .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(lineWidth: 1).foregroundColor(.gray))
                .padding(.bottom, 10)
            
            HStack {
                Text("Enter Guest Email")
                Spacer()
            }
            
            TextField("Guest Email", text: $guestEmail)
                .padding(8)
                .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(lineWidth: 1).foregroundColor(.gray))
            
            HStack {
                
                Text("Number of Guest")
                
                Spacer()
                
                Picker("Number of Guest" ,selection: $numberOfGuest) {
                    
                    ForEach(1...15, id: \.self) {
                        
                        Text("\($0)")
                        
                    }
                }
                .pickerStyle(.menu)
            }
            
            
            //              TODO: starting Date() should be next 15 minute interval.
            //                Now on default it shows current time
//            DatePicker("Reserve Date & Time", selection: $reservationDate, in: Date()...Date().addingTimeInterval(15552000))
//                .onAppear {
//                    UIDatePicker.appearance().minuteInterval = 15
//                }
//                .onDisappear{
//                    UIDatePicker.appearance().minuteInterval = 1
//                }
//            
//                .tint(.red)
//                .padding(.bottom, 5)
            
            Divider()
            
                .padding(.bottom, 5)
            
        }
        .padding(.horizontal, 5)
        
    }
    
}

extension NewReservationForm {
    
// TODO: Implement a reservation hour minute check
    
    
    
    
}

struct NewReservationForm_Previews: PreviewProvider {
    static var previews: some View {
        NewReservationForm(guestName: .constant("guest"), guestPhoneNumber: .constant("12345"), guestEmail: .constant("abc@abc.com"), numberOfGuest: .constant(3), reservationDate: .constant(.now))
    }
}
