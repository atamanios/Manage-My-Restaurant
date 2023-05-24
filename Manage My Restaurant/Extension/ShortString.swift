//
//  ShortString.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 13/04/2023.
//

import Foundation

extension String {
//  Get a short string without changing the value of actual string
    func shorter(_ offsetBy: Int) -> String {
        let startIndex = self.startIndex
        let index = self.index(startIndex, offsetBy: offsetBy)
        
        return String(self[startIndex..<index])
    }
    
    
}
