//
//  IndepthTableView.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 13/04/2023.
//

import SwiftUI

struct IndepthTableView: View {
    
    @ObservedObject var tableItem: Tables
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                Text("Table Number: \(tableItem.tableNumber)")
                
                Text("Table Capacity: \(tableItem.seatingCapacity)")
                
            }
        }
    }
}

struct IndepthTableView_Previews: PreviewProvider {
    static var previews: some View {
        IndepthTableView(tableItem: .init())
    }
}
