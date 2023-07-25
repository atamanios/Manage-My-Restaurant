//
//  HourAndMinuteDisplay.swift
//  Manage My Restaurant
//
//  Created by Ataman Deniz on 25/07/2023.
//

import Foundation

extension DateComponents {
    
    func hourAndMinuteDisplay()-> String  {
        
        guard let minute =  self.minute else { return "" }
        guard let hour = self.hour else { return "" }
        var output = ""
        
        if hour < 10 {
            
            output.append("0")
            output.append("\(hour)")
            
        } else {
            
            output.append("\(hour)")
            
        }
        
        output.append(":")
         
        if minute < 10 {
            
            output.append("0")
            output.append("\(minute)")
            
        } else {
            
            output.append("\(minute)")
        }
        return output
    }

}
