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
                    
                        Text("\(tableItem.tableNumber)")
                        .padding(6)
                        .overlay (
                            Circle()
                                .stroke(.black, lineWidth: 2))
                    
                    Spacer()
                    
                    Image(systemName: "chair")
                    Text("\(tableItem.seatingCapacity)")
                    
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .padding(.bottom, 5)
                
                Spacer()
                
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
                .padding(.bottom, 10)
            }
            .padding(.horizontal, 10)
            .frame(height:125)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.black, lineWidth: 1))
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
        
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        var fetchedGuests: [Guest] = []
        
        do {
            fetchedGuests = try viewContext.fetch(request)
        } catch let error {
            print("Error fetching \(error)")
        }
        
      
        
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
