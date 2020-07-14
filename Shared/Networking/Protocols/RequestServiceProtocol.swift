//
//  RequestServiceProtocol.swift
//  TrainTrack
//
//  Created by Archie Edwards on 30/06/2020.
//

import Foundation

protocol RequestServiceProtocol {
    func getStationUpdate(_ stationReq: StationRequest, completion: @escaping (Result<Data, Error>) -> Void)
}

extension NetworkManager : RequestServiceProtocol {
    func getStationUpdate(_ stationReq: StationRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        executeRequest(request: stationReq.getURL()){ result in
            completion(result)
        }
    }
}
