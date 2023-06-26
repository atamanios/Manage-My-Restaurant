//
//  Onboarding.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 03/04/2023.
//

import SwiftUI
import CoreData



//TODO: Saving to cloud when there are already entries to core data.
//A user alert saying the previous tables will be deleted better approach.

//TODO: implement a navigationPath variable

struct Onboarding: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject private var userSettings: UserSettings
    
    let defaults = UserDefaults.standard
    
    @State var numberOfTables = 1
    @State var openDaysSheet = false
    @State var openHour: Date = .now
    @State var closeHour: Date = Date(timeIntervalSinceNow: 36000)
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                Spacer()
                
                HStack {
                    Text("Enter the name of the restaurant")
                    Spacer()
                }
                .padding(.vertical, 3)
                
                TextField("Name of the Restaurant", text: $userSettings.nameOfTheRestaurant)
                    .padding(8)
                    .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(lineWidth: 1).foregroundColor(.gray))
                    .padding(.bottom, 10)
                
                HStack {
                    
                    Text("Please select the number of tables in the restaurant").multilineTextAlignment(.leading)
                        .frame(width:200)
                    Spacer()
                    
                    Picker("Number of Tables", selection: $numberOfTables) {
                        
                        ForEach(1...15, id: \.self) {
                            
                            Text("\($0)")
                        }
                    }
                    .onChange(of: numberOfTables) { newValue in
                        print("Selected value is \(newValue)")
                    }
                    .pickerStyle(.wheel)
                }
                .padding(8)
                .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(lineWidth: 1).foregroundColor(.gray))
                .padding(.bottom, 10)
                
                //                TODO: open days does not work properly
                //                It forces isOpen to true all the time.
                //                Might require creation of dummy array to transfer open days and display them.
                HStack {
                    
                    Text("Open days")
                    
                    Spacer()
                    
                    HStack {
                        
                        if Array(userSettings.openDays.filter{$0.isOpen}).count == 7 {
                            
                            Text("Everyday")
                            
                        } else {
                            
                            ForEach(Array(userSettings.openDays.filter{$0.isOpen})) { item in
                                
                                Text(item.day.shorter(3))
                                
                            }
                        }
                    }
                }
                .padding(8)
                .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(lineWidth: 1).foregroundColor(.gray))
                .padding(.bottom, 10)
                .onTapGesture {
                    openDaysSheet.toggle()
                }
                
                DatePicker("Opening Hours", selection: $openHour, displayedComponents: .hourAndMinute)
                    .onAppear {
                        UIDatePicker.appearance().minuteInterval = 15
                    }
                    .onDisappear {
                        UIDatePicker.appearance().minuteInterval = 1
                    }
                
                DatePicker("Closing Hours", selection: $closeHour, displayedComponents: .hourAndMinute)
                    .onAppear {
                        UIDatePicker.appearance().minuteInterval = 15
                    }
                    .onDisappear {
                        UIDatePicker.appearance().minuteInterval = 1
                    }
                
                Spacer()
            }
            .padding(.horizontal)
            
            .sheet(isPresented: $openDaysSheet) {
                
                OpenDaysSheet()
            }
            
            .navigationDestination(isPresented: $userSettings.isOnboarded) {
                
                ContentView()
                    .navigationBarBackButtonHidden()
                
            }
            .onAppear {
                
                //                TODO: Guard check network connection and icloud sync!!!
                
                if defaults.bool(forKey: kIsOnboarded) {
                    
                    userSettings.resetPublishedValues()
                    
                } else {
                    
                    userSettings.updateKeyValues()
                    ContextOperations.batchDelete("Table", viewContext)
                    
                }
            }
            .toolbar {
                
                ToolbarItem(placement: .bottomBar) {
                    
                    Button(action: {
                        
                        //                TODO: Check new table addition
                        //                    TODO: Implement save operation
                        
                        dateToDateComponents()
                        createTables()
                        userSettings.isOnboarded = true
                        userSettings.updateKeyValues()
                        
                    }, label: {
                        
                        Text("Save Settings")
                        
                    })
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    
    }
}

extension Onboarding {
    
    func createTables() {
        
        ContextOperations.batchCreate(viewContext, numberOfTables)
        
    }
    
    func dateToDateComponents() {
        
        userSettings.openingHours = Calendar.current.dateComponents([.hour, .minute], from: openHour)
        
        userSettings.closingHours = Calendar.current.dateComponents([.hour, .minute], from: closeHour)
        
    }
    
    
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
