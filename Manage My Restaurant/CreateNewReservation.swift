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
    
//    TODO: predicate calls reservationDate variable before it is initialized. Find another method.
        
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
                    
                
                FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptor()) { (tables: [Table]) in
                    
                    List {
                        
                        ForEach(tables) { table in
                            
                            let _ = print("The table is \(table.tableNumber) and \(table) ")
                            
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
        newGuest.reservationID = UUID()
        newGuest.name = guestName
        newGuest.email = guestEmail
        newGuest.phone = guestPhoneNumber
        newGuest.date = reservationDate
       
        addRelation(selectedTableNumber: activeTable, guest: newGuest)
        
        
        ContextOperations.save(viewContext)
    }
    func buildPredicate() -> NSPredicate {
//        TODO: How to predicate tables wrt reserved dates
//        let startingRange = Date(timeInterval: -7200, since: reservationDate)
//
//        let endingRange = Date(timeInterval: 7200, since: reservationDate)
//
//        let startingPredicate = NSPredicate(format: "date > %@", startingRange as NSDate)
//
//        let endingPredicate = NSPredicate(format: "date < %@", endingRange as NSDate)

        let entityPredicate = NSPredicate(format: "entity = %@", Table.entity())
        
//        let datePredicate = NSCompoundPredicate(type: .not, subpredicates: [startingPredicate,endingPredicate])
//
//        let compoundedPredicate = NSCompoundPredicate(type: .and, subpredicates: [datePredicate,entityPredicate])
//
//        return compoundedPredicate
//
        return entityPredicate
        
//        return NSPredicate(value: true)
    }
    
    func buildSortDescriptor() -> [NSSortDescriptor] {
        
        
       return [NSSortDescriptor(keyPath: \Table.tableNumber, ascending: true)]
        
    }
    
    func addRelation(selectedTableNumber: Int, guest: Guest) {
        
        let request = NSFetchRequest<Table>(entityName: "Table")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Table.tableNumber, ascending: true)]
        
        request.predicate = NSCompoundPredicate(type: .and, subpredicates:
                                                    [NSPredicate(format: "tableNumber = %i", Int64(selectedTableNumber)),
                                                     NSPredicate(format: "entity = %@", Table.entity())])
    
        
        if var result = try? viewContext.fetch(request) {
            
            print("fetchedresult is: \(result.first?.tableNumber)")
            
            result.first?.addToToGuest(guest)
            
            guest.tableNumber = result.first!.tableNumber
            print("The table number is: \(guest.tableNumber)")
            if result.count > 1 {
                let winner = result.first
                result.removeFirst()
                
                result.forEach { table in
                    if let guestSet = table.toGuest {
                        for case let guest as Guest in guestSet {
                            table.removeFromToGuest(guest)
                            winner?.addToToGuest(guest)
                        }
                    }
                    viewContext.delete(table)
                }
            }
        }
    }
    
    
    
}

struct CreateNewReservation_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewReservation()
    }
}
