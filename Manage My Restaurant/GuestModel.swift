//
//  GuestModel.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 02/04/2023.
//

import Foundation

struct GuestModel: Codable {
    
    var id = UUID()
    var date: String
    var name: String
    var phone: String
    var numberOfGuest: Int
    
    
    init(id: UUID = UUID(), date: String, name: String, phone: String, numberOfGuest: Int) {
        self.id = id
        self.date = date
        self.name = name
        self.phone = phone
        self.numberOfGuest = numberOfGuest
    }
}
