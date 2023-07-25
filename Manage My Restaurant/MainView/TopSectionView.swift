//
//  TopSectionView.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 14/06/2023.
//

import SwiftUI

struct TopSectionView: View {
    
    @Binding var today: Date
    @Binding var showGuestNumberPicker: Bool
    @Binding var numberOfGuest: Int
    
    var body: some View {
        
        VStack {
            
            companyLogo
            
            HStack {
                
                Spacer()
                
                DatePicker("Date", selection: $today, in: Date()...Date(timeIntervalSinceNow: 15552000), displayedComponents: .date)
                    .tint(.red)
                    .padding(.bottom, 5)
                
                Spacer()
                
            }
                if showGuestNumberPicker {
                    
                    HStack {
                        
                        Text("Choose Number of Guest")
                        
                        Picker("Number of Guest", selection: $numberOfGuest) {
                            
                            ForEach(2...10, id: \.self) {
                                
                                Text("\($0)")
                            }
                        }
                    }
                }
        }
        .background(Color.mint)
        .padding(.top, 5)
        
    }
}

extension TopSectionView {
    
    var companyLogo: some View {
        
        Image("Company Logo")
            .resizable().scaledToFit()
            .frame(height:75)
            .padding()
    }
}

//struct TopSectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopSectionView()
//    }
//}
