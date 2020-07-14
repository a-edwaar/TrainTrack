//
//  Service.swift
//  TrainTrack
//
//  Created by Archie Edwards on 28/06/2020.
//

import Foundation

public struct Service: Identifiable{
    public let id: String
    let platform: String?
    let station: String /// if departing its destination and if arriving its origin
    let status: Status
    let scheduledTime: String
    let expMins: Int
}
