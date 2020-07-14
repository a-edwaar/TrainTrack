//
//  StationView.swift
//  TrainTrack
//
//  Created by Archie Edwards on 02/07/2020.
//

import SwiftUI

struct StationView: View {
    
    var stationReq : StationRequest
    @ObservedObject private var stationModel = StationViewModel()
    
    var body: some View {
        VStack{
            if stationModel.services == nil {
                StationLoadingView(stationID: stationReq.station?.id ?? "?")
            }else{
                ServicesForStationView(stationReq: stationReq, services: self.stationModel.services!)
            }
        }.onAppear {
            guard let _ = stationReq.station?.id else{
                return
            }
            stationModel.getLatest(stationReq)
        }
    }
}

struct StationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StationView(stationReq: StationRequest(station: Station(id: "BHM", name: "Birmingham New Street"), filterStation: Station(id: "MAN", name: "Manchester"), type: .departure))
            StationView(stationReq: StationRequest(station: Station(id: "BHM", name: "Birmingham New Street"), filterStation: Station(id: "MAN", name: "Manchester"), type: .departure))
                .preferredColorScheme(.dark)
        }
    }
}
