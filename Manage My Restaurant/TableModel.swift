//
//  TableModel.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 02/04/2023.
//

import Foundation

struct TableModel: Codable {
    
    //TODO: reservedTime array of Strings?
    //TODO: implement a formatted strings for time slot occupancy
    
    var id: String
    var reservedTime: String
    var reservation: String
    var seatingCapacity: Int
    
    init(id: String, reservedTime: String, reservation: String, seatingCapacity: Int) {
        self.id = id
        self.reservedTime = reservedTime
        self.reservation = reservation
        self.seatingCapacity = seatingCapacity
    }
}
