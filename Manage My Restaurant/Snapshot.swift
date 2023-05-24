//
//  Snapshot.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 03/04/2023.
//

import SwiftUI

struct Snapshot: View {
    var body: some View {
        
        TabView{
                VStack{
                    
                    Text("Todays Overview")
                    
                    Text("First reservation")
                    
                    Text("Last reservation")
                    
                    Text("Cool Visual about occupancy")
                    
                }
                
                
                VStack {
                    
                    Text("This Weeks overview")
                    
                    Text("Cool Visual about occupancy")
                    
                    
                }
            }
        .tabViewStyle(.page)
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct Snapshot_Previews: PreviewProvider {
    static var previews: some View {
        Snapshot()
    }
}
