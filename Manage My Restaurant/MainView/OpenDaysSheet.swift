//
//  OpenDaysSheet.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 04/04/2023.
//

import SwiftUI

struct OpenDaysSheet: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject private var userSettings: UserSettings
    
    var body: some View {
    
        VStack{
            
            Spacer()
            List {
             
                ForEach(Array(userSettings.openDays)) { item in
                    
                    ToggleView(text: item.day, toggle: item.isOpen)
                        
                }
            }
            .listStyle(.plain)
            
            Spacer()
            
            Button(action: {
                
                dismiss()
                
            }, label: {
                
                Text("Done")
                    .frame(width:150)
                
            })
            .buttonStyle(.bordered)
            
        }
        .font(.title2)
    }
}

struct ToggleView: View {
    
    var text: String
    
    @State var toggle = true
    
    var body: some View {
        
        Toggle(isOn: $toggle) {
            
            Text(text)
        }
        .toggleStyle(iOSCheckboxToggleStyle())
    }
}

struct OpenDaysSheet_Previews: PreviewProvider {
    static var previews: some View {
        OpenDaysSheet()
    }
}
