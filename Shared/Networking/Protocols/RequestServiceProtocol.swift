//
//  RequestServiceProtocol.swift
//  TrainTrack
//
//  Created by Archie Edwards on 30/06/2020.
//

import Foundation

protocol RequestServiceProtocol {
    func getStationUpdate(station: String, type: Type, completion: @escaping (Result<Data, Error>) -> Void)
}

extension NetworkManager : RequestServiceProtocol {
    func getStationUpdate(station: String, type: Type, completion: @escaping (Result<Data, Error>) -> Void) {
        executeRequest(request: URLRequest.station(station: station, type: type)){ result in
            completion(result)
        }
    }
}
