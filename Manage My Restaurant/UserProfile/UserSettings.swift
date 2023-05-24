//
//  UserSettings.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 10/04/2023.
//

import Foundation

let kIsOnboarded = "sync_kIsOnboarded"
let kNameOfTheRestaurant = "sync_kNameOfTheRestaurant"
let kOpenDays = "sync_kOpenDays"
let kOpeningHours = "sync_kOpeningHours"
let kClosingHours = "sync_kClosingHours"
let kRestaurantLogo = "sync_kRestaurantLogo"

class UserSettings: ObservableObject {
    
    let defaults = UserDefaults.standard
    
    @Published var isOnboarded: Bool
    @Published var nameOfTheRestaurant: String
    @Published var openDays: [Day]
    @Published var openingHours: Date
    @Published var closingHours: Date
    
    init() {
       
        isOnboarded = false
        nameOfTheRestaurant = ""
        openDays = [.init(day: .monday), .init(day: .tuesday), .init(day: .wednesday), .init(day: .thursday), .init(day: .friday), .init(day: .saturday), .init(day: .sunday)]
        openingHours = .now
        closingHours = .now
        
    }
        
    func updateKeyValues() {
        
        defaults.set(isOnboarded, forKey: kIsOnboarded)
        defaults.set(nameOfTheRestaurant, forKey: kNameOfTheRestaurant)
//        defaults.set(openDays, forKey: kOpenDays)
        encodeCustomObject()
        defaults.set(openingHours, forKey: kOpeningHours)
        defaults.set(closingHours, forKey: kClosingHours)

    }
    
    func resetPublishedValues() {
        
        isOnboarded = defaults.bool(forKey: kIsOnboarded)
        nameOfTheRestaurant = defaults.string(forKey: kNameOfTheRestaurant) ?? ""
//        openDays = defaults.object(forKey: kOpenDays) as! [Day]
        decodeCustomObject()
        openingHours = defaults.object(forKey: kOpeningHours) as! Date
        closingHours = defaults.object(forKey: kClosingHours) as! Date
        
    }
    
    private func encodeCustomObject() {
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(openDays)
            
            defaults.set(data, forKey: kOpenDays)
            
        } catch (let error) {
            
            print("Unable to encode: \(error)")
            
        }
        
        
    }
    private func decodeCustomObject() {
        
        if let data = defaults.data(forKey: kOpenDays) {
            
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode([Day].self, from: data)
                
                openDays = data
                
            } catch(let error) {
                
                print("Unable to decode \(error)")
                
            }
        }
        
    }
    
    private func startUpCheck() -> Bool {
        
        if defaults.bool(forKey: kIsOnboarded) && defaults.string(forKey: kNameOfTheRestaurant) != "" {
            
            return true
            
        } else { return false }
    }
    
}

