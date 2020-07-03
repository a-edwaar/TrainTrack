//
//  Status.swift
//  TrainTrack
//
//  Created by Archie Edwards on 28/06/2020.
//

import Foundation

enum Status: String, Codable {
    case arrived = "ARRIVED"
    case cancelled = "CANCELLED"
    case changeOfIdentity = "CHANGE OF IDENTITY"
    case changeOfOrigin = "CHANGE OF ORIGIN"
    case early = "EARLY"
    case late = "LATE"
    case noReport = "NO REPORT"
    case offRoute = "OFF ROUTE"
    case onTime = "ON TIME"
    case reinstatement = "REINSTATEMENT"
    case startsHere = "STARTS HERE"
}
