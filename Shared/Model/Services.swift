//
//  Services.swift
//  TrainTrack
//
//  Created by Archie Edwards on 28/06/2020.
//

import Foundation

public struct Services: Codable{
    let all : [Service]
    enum CodingKeys: String, CodingKey {
        case all = "all"
    }
}
