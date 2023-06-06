//
//  CreateNewReservation.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 14/04/2023.
//

import SwiftUI
import CoreData

struct CreateNewReservation: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    
    
    @State var guestName = ""
    @State var guestPhoneNumber = ""
    @State var guestEmail = ""
    @State var reservationDate:Date = .now
    @State var activeTable = 1
    @State var isDatePickerPresented = false
    @State var numberOfGuest = 1
    
//    TODO: predicate calls reservationDate variable before it is initialized. Find another method.
        
//    TODO: move views to extension for code reading clarity
    
    var body: some View {
        
        NavigationStack {
                        
                NewReservationForm(guestName: $guestName, guestPhoneNumber: $guestPhoneNumber, guestEmail: $guestEmail, numberOfGuest: $numberOfGuest, reservationDate: $reservationDate)
                    
                AvailableTableList(activeTable: $activeTable)
                
           
            
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
    
}

extension CreateNewReservation {
    
    func createNewGuest() {
        
        let newGuest = Guest(context: viewContext)
        newGuest.reservationID = UUID()
        newGuest.name = guestName
        newGuest.email = guestEmail
        newGuest.phone = guestPhoneNumber
        newGuest.date = reservationDate
        newGuest.numberOfGuest = Int64(numberOfGuest)
       
        addRelation(selectedTableNumber: activeTable, guest: newGuest)
        
        ContextOperations.save(viewContext)
    }
    
    
    func addRelation(selectedTableNumber: Int, guest: Guest) {
        
        let request = NSFetchRequest<Table>(entityName: "Table")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Table.tableNumber, ascending: true)]
        
        request.predicate = NSCompoundPredicate(type: .and, subpredicates:
                                                    [NSPredicate(format: "tableNumber = %i", Int64(selectedTableNumber)),
                                                     NSPredicate(format: "entity = %@", Table.entity())])
    
        if var result = try? viewContext.fetch(request) {
            
            result.first?.addToToGuest(guest)

        }
    }
}


struct CreateNewReservation_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewReservation()
    }
}
