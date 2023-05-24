//
//  CreateNewReservation.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 14/04/2023.
//

import SwiftUI

struct CreateNewReservation: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @State var guestName = ""
    @State var guestPhoneNumber = ""
    @State var guestEmail = ""
    @State var reservationDate:Date = .now
    @State var activeTable = 1
    @State var isDatePickerPresented = false
    
//  predicate calls reservationDate variable before it is initialized. Find another method.
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Tables.tableNumber, ascending: true)],
//        predicate: NSPredicate(value: true),
//        animation: .default)
//
//    private var tables: FetchedResults<Tables>
    
//    TODO: move views to extension for code reading clarity
    
    var body: some View {
        NavigationStack {
                        
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
                    .padding(.bottom, 10)
                
//              TODO: starting Date() should be next 15 minute interval.
//                Now on default it shows current time
                DatePicker("Reserve Date & Time", selection: $reservationDate, in: Date()...Date().addingTimeInterval(15552000))
                    .onAppear {
                        UIDatePicker.appearance().minuteInterval = 15
                    }
                    .onDisappear{
                        UIDatePicker.appearance().minuteInterval = 1
                    }
                
                    .tint(.red)
                    .padding(.bottom, 5)
                Divider()
                    .padding(.bottom, 5)
                    
                
                FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptor()) {
                    (tables: [Tables]) in
                    
                    List(tables, id: \.self) { table in
                        
                        let _ = print(table)
                        
                        HStack {
                            
                            Image(systemName: activeTable == Int(table.tableNumber) ?  "circle.inset.filled" : "circle" )
                                .padding(.trailing, 5)
                            
                            Text("Table: \(table.tableNumber)")
                                .padding(.trailing, 5)
                            
                            Text("Available Time Slots")
                            
                        }
                        
                        .onTapGesture {
                            activeTable = Int(table.tableNumber)
                        }
                    }
                    
                    .listStyle(.plain)
                }
                
                
            }
            .padding()
            
            .toolbar {
            
                ToolbarItem(placement: .bottomBar) {
                    
                    Button(action: {
                        
                        createNewGuest()
                    
                        
//                     TODO: Create Reservation
                        
                    }, label: {
                        Text("Save Reservation")
                    })
                    
                }
            }
            
        }
    }
    func createNewGuest() {
        
        let newGuest = Guest(context: viewContext)
        newGuest.name = guestName
        newGuest.email = guestEmail
        newGuest.phone = guestPhoneNumber
        newGuest.date = reservationDate
        newGuest.reservation = Tables(context: viewContext)
        newGuest.tableNumber = Int16(activeTable)
    
        
        ContextOperations.save(viewContext)
    }
    func buildPredicate() -> NSPredicate {
        
        let startingRange = Date(timeInterval: -7199, since: reservationDate)
        
        let endingRange = Date(timeInterval: 7199, since: reservationDate)
        
        let startingPredicate = NSPredicate(format: "date < %@", startingRange as NSDate)
        
        let endingPredicate = NSPredicate(format: "date > %@", endingRange as NSDate)
        
        let compoundedPredicate = NSCompoundPredicate(type: .and, subpredicates: [startingPredicate,endingPredicate])
        
        return compoundedPredicate
    }
    
    func buildSortDescriptor() -> [NSSortDescriptor] {
        
        
       return [NSSortDescriptor(keyPath: \Tables.tableNumber, ascending: true)]
        
    }
    
}

struct CreateNewReservation_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewReservation()
    }
}
