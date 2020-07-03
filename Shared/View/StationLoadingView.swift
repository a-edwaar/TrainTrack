//
//  StationLoadingView.swift
//  TrainTrack
//
//  Created by Archie Edwards on 05/07/2020.
//

import SwiftUI

struct StationLoadingView: View {
    var stationID : String
    var body: some View {
        VStack{
            Spacer()
            ProgressView("Getting latest updates for \(stationID)")
            Spacer()
        }
    }
}

struct StationLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        StationLoadingView(stationID: "BHM")
    }
}
