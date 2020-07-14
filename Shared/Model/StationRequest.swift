//
//  StationRequest.swift
//  TrainTrack
//
//  Created by Archie Edwards on 17/07/2020.
//

import Foundation

public class StationRequest: ObservableObject {
    @Published var station : Station?
    @Published var filterStation : Station?
    @Published var type : Type
    
    init(station: Station?, filterStation: Station?, type: Type) {
        self.station = station
        self.filterStation = filterStation
        self.type = type
    }
    
    func getURL() -> URLRequest{
        return URLRequest.station(stationReq: self)
    }
}
