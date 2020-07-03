//
//  Station.swift
//  TrainTrack
//
//  Created by Archie Edwards on 28/06/2020.
//

import Foundation

public struct Station: Identifiable, Codable{
    public let id: String
    let name: String?
    var departures: Services?
    let arrivals: Services?
    
    enum CodingKeys: String, CodingKey {
        case id = "station_code"
        case name = "station_name"
        case departures = "departures"
        case arrivals = "arrivals"
    }
}
