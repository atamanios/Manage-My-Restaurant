//
//  GuestListView.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 13/06/2023.
//

import SwiftUI
import CoreData

struct GuestListView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject private var userSettings: UserSettings
    
    @Binding var today: Date
    
    var body: some View {
        
        NavigationStack {
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptor()) { (guests: [Guest]) in
                
                if guests.isEmpty {
                    
                    HStack {
                        
                        Spacer()
                    
                        Text("NO RESERVATION FOR TODAY")
                            .font(.title2)
                            .padding()
                        
                        Spacer()
                    }
                    .background(Color.gray)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.black, lineWidth: 1))
                    
                } else {
                    
                    List {
                        
                        ForEach(guests) { guest in
                            HStack {
                                Text("Welcome Guest: \(guest.name ?? "N/A")")
                                    .padding()
                                Text("Date \(guest.phone ?? "N/A")")
                            }
                        }
                    }
                    .listStyle(.plain)
                    
                }
            }
        }
    }
}
    
extension GuestListView {
        
    func buildPredicate() -> NSPredicate {
        
        let endOfDay = Date(timeInterval: 86400, since: day())
        
        let datePredicate = NSPredicate(format: "date >= %@ AND date <= %@" , day() as NSDate, endOfDay as NSDate)
        
        return datePredicate
    }
    
    func day() -> Date {
        
        var components = Calendar.current.dateComponents([.day, .month, .year], from: today)
        components.hour = 0
        components.minute = 0
        
        let returnedDate = Calendar.current.date(from: components) ?? today
        
        return returnedDate
    }
    
    func buildSortDescriptor() -> [NSSortDescriptor] {
        
        return [NSSortDescriptor(keyPath: \Guest.date, ascending: true)]
        
    }
}

struct GuestListView_Previews: PreviewProvider {
    static var previews: some View {
        GuestListView(today: .constant(.now))
    }
}
