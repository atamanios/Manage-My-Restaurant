//
//  iOSCheckboxToggleStyle.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 10/04/2023.
//

import SwiftUI

struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        
        Button(action: {

            configuration.isOn.toggle()

        }, label: {
            HStack {
        
                configuration.label
                    .frame(alignment: .leading)
        
                Spacer()
            
                Image(systemName: "checkmark").opacity(configuration.isOn ? 1 : 0)
                
            }
            .foregroundColor(.black)
        })
    }
}

