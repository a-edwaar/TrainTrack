//
//  StationView.swift
//  TrainTrack
//
//  Created by Archie Edwards on 02/07/2020.
//

import SwiftUI

struct StationView: View {
    
    var stationID : String
    var stationName : String
    @StateObject private var stationModel = StationViewModel()
    
    var body: some View {
        VStack{
            if stationModel.station == nil {
                StationLoadingView(stationID: stationID)
            }else{
                ServicesForStationView(station: stationName, type: stationModel.type, services: self.stationModel.station?.getServices(type: self.stationModel.type).all ?? [])
            }
        }.onAppear {
            stationModel.getLatest(stationID)
        }
    }
}

struct StationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StationView(stationID: "BHM", stationName: "Birmingham New Street")
                .preferredColorScheme(.dark)
            StationView(stationID: "BHM", stationName: "Birmingham New Street")
                .preferredColorScheme(.light)
        }
    }
}
