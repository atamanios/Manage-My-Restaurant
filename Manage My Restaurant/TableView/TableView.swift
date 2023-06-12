//
//  TableView.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 13/04/2023.
//

import SwiftUI
import CoreData

struct TableView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var tableItem: Table
    @Binding var date: Date
        
    var body: some View {
        
        NavigationStack {
            
            VStack{
                
                HStack {
                    
                    Text("Number: \(tableItem.tableNumber)")
                    
                    Spacer()
                    
                    Text("Number of Seating: \(tableItem.seatingCapacity)")
                    
                }.padding(.vertical)
                
                ScrollView(.horizontal) {
                    
                    HStack {
                        
                        Text("Reserved Slots")
                            .padding(5)
                        
                        ForEach(reservedGuests(), id: \.self) { guest in
                            
                            Text(guest.date!, format: .dateTime.hour().minute())
                                .padding(5)
                            
                        }
                        
                    }
                }
            }
            .padding()
            .frame(height:100)
        }
    }
    

    
    
    
    
}

extension TableView {
    
    func reservedGuests () -> [Guest] {
     
        let request: NSFetchRequest<Guest> = Guest.fetchRequest()
        
        let tablePredicate = NSPredicate(format: "toTable.tableNumber = %i", tableItem.tableNumber)
        let endOfDay = Date(timeInterval: 86400, since: day())
        let datePredicate = NSPredicate(format: "date >= %@ AND date <= %@" , day() as NSDate, endOfDay as NSDate)
        
        request.predicate = NSCompoundPredicate(type: .and, subpredicates: [tablePredicate, datePredicate])
        
//        request.predicate = tablePredicate
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        var fetchedGuests: [Guest] = []
        
        do {
            fetchedGuests = try viewContext.fetch(request)
        } catch let error {
            print("Error fetching \(error)")
        }
        
        print("list of Guests \(fetchedGuests)")
        
        return fetchedGuests
    }
    
    func day() -> Date {
        
        var components = Calendar.current.dateComponents([.day, .month, .year], from: date)
        components.hour = 0
        components.minute = 0
        
        let returnedDate = Calendar.current.date(from: components) ?? date
        
        return returnedDate
    }
    
    
    
}


struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView(tableItem: .init(), date: .constant(Date.now))
    }
}
