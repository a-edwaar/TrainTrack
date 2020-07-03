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
                    completion(.success(sortByExpectedMins(station: stationStatus, type: type)))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func sortByExpectedMins(station: Station, type: Type) -> Station{
        guard var services = type == .departure ? station.departures?.all : station.arrivals?.all else{
            return station
        }
        services.sort(by: { (comparingService, currentService) in
            let expMinsComparingService = type == .departure ? comparingService.expDepartureMins : comparingService.expArrivalMins
            let expMinsCurrentService = type == .departure ? currentService.expDepartureMins : currentService.expArrivalMins
            if expMinsComparingService == nil{
                return false
            }else if expMinsCurrentService == nil {
                /// no time estimate needs to go to back of list
                return true
            }else if expMinsComparingService! < expMinsCurrentService! {
                return true
            }
            return false
        })
        var newSortedStation = station
        newSortedStation.setServices(Services(all: services), type: type)
        return newSortedStation
    }
}
