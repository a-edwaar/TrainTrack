//
//  Service+SwiftUI.swift
//  TrainTrack
//
//  Created by Archie Edwards on 03/07/2020.
//
import Foundation

extension Service{
    func expMinsForProgressBar() -> Float{
        /// need progress bar friendly value from 0 to 1
        var expMinsData = expMins
        
        if expMinsData > 120 {
            expMinsData = 120
        }else if expMinsData < 0 {
            expMinsData = 0
        }
        return 1 - (Float(expMinsData) / 120)
    }
    
    func expMinsForStatus() -> String{
        switch expMins{
        case _ where expMins < 1:
            return "Due"
        case 1:
            return "\(expMins) min"
        default:
            return "\(expMins) mins"
        }
    }
}
