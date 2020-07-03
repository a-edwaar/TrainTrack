//
//  Service.swift
//  TrainTrack
//
//  Created by Archie Edwards on 28/06/2020.
//

import Foundation

public struct Service: Identifiable, Codable{
    public let id: String
    let platform: String?
    let operatorName: String?
    let origin: String?
    let destination: String?
    let status: Status?
    let aimedDepartureTime: String?
    let aimedArrivalTime: String?
    let expDepartureTime: String?
    let expArrivalTime: String?
    let expDepartureMins: Float?
    let expArrivalMins: Float?
    enum CodingKeys: String, CodingKey {
        case id = "train_uid"
        case platform
        case operatorName = "operator_name"
        case origin = "origin_name"
        case destination = "destination_name"
        case status
        case aimedDepartureTime = "aimed_departure_time"
        case aimedArrivalTime = "aimed_arrival_time"
        case expDepartureTime = "expected_departure_time"
        case expArrivalTime = "expected_arrival_time"
        case expDepartureMins = "best_departure_estimate_mins"
        case expArrivalMins = "best_arrival_estimate_mins"
    }
}
