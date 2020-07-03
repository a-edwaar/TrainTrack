//
//  Service+SwiftUI.swift
//  TrainTrack
//
//  Created by Archie Edwards on 03/07/2020.
//

import SwiftUI

extension Service{
    func expMinsForProgressBar(type: Type = .departure) -> Float{
        /// need progress bar friendly value from 0 to 1
        var expMinsData = expMins(type: type)
        
        if expMinsData > 120 {
            expMinsData = 120
        }else if expMinsData < 0 {
            expMinsData = 0
        }
        
        return 1 - (expMinsData / 120)
    }
    
    func expMinsForStatus(type: Type = .departure) -> String{
        let expMinsData = Int(expMins(type: type))
        switch expMinsData{
        case _ where expMinsData < 1:
            return "Due"
        case 1:
            return "\(expMinsData) min"
        default:
            return "\(expMinsData) mins"
        }
    }
    
    private func expMins(type: Type = .departure) -> Float{
        return type == .departure ? (self.expDepartureMins ?? 0) : (self.expArrivalMins ?? 0)
    }
}
