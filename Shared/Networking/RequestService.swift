//
//  Service.swift
//  TrainTrack
//
//  Created by Archie Edwards on 29/06/2020.
//

import Foundation

public struct RequestService {
    
    private let r : RequestServiceProtocol
    private let j : JSONDecoderProtocol
    
    init(r: RequestServiceProtocol = NetworkManager(), j: JSONDecoderProtocol = JSONDecoder()) {
        self.r = r
        self.j = j
    }
    
    public func getStationUpdate(station: String, type: Type = .departure, completion: @escaping (Result<Station, Error>) -> Void) {
        r.getStationUpdate(station: station, type: type) { result in
            switch result {
            case .success(let data):
                do {
                    let stationStatus = try j.decode(Station.self, from: data)
                    completion(.success(stationStatus))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
