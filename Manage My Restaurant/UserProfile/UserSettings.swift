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
//    TODO: set openDays, opening hour and closing hour as datecomponents
//    Compute Date for particular day from datecomponents
    
    let defaults = UserDefaults.standard
    
    @Published var isOnboarded: Bool
    @Published var nameOfTheRestaurant: String
    @Published var openDays: [Day]
    @Published var openingHours: DateComponents
    @Published var closingHours: DateComponents
    
    init() {
       
        isOnboarded = false
        nameOfTheRestaurant = ""
        openDays = [.init(day: .monday), .init(day: .tuesday), .init(day: .wednesday), .init(day: .thursday), .init(day: .friday), .init(day: .saturday), .init(day: .sunday)]
        openingHours = Calendar.current.dateComponents([.hour, .minute], from: .now)
        closingHours = Calendar.current.dateComponents([.hour, .minute], from: Date(timeIntervalSinceNow: 36000))
        
    }
        
    func updateKeyValues() {
        
        defaults.set(isOnboarded, forKey: kIsOnboarded)
        defaults.set(nameOfTheRestaurant, forKey: kNameOfTheRestaurant)
        
        encodeCustomObject()


    }
    
    func resetPublishedValues() {
        
        isOnboarded = defaults.bool(forKey: kIsOnboarded)
        nameOfTheRestaurant = defaults.string(forKey: kNameOfTheRestaurant) ?? ""
        
        decodeCustomObject()
        
    }
    
    private func encodeCustomObject() {
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(openDays)
            
            defaults.set(data, forKey: kOpenDays)
            
        } catch (let error) {
            
            print("Unable to encode: \(error)")
            
        }
        
        do {
            
            let encoder = JSONEncoder()
            let data = try encoder.encode(openingHours)
            
            defaults.set(data, forKey: kOpeningHours)
            
        } catch (let error) {
            
            print("Unable to encode: \(error)")
        }
        
        do {
            
            let encoder = JSONEncoder()
            let data = try encoder.encode(closingHours)
            
            defaults.set(data, forKey: kClosingHours)
            
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
        
        if let data = defaults.data(forKey: kOpeningHours) {
            
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(DateComponents.self, from: data)
                
                openingHours = data
            } catch (let error) {
                
                print("Unable to decode \(error)")
            }
        }
        
        if let data = defaults.data(forKey: kClosingHours) {
            
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(DateComponents.self, from: data)
                
                closingHours = data
            } catch (let error) {
                
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

