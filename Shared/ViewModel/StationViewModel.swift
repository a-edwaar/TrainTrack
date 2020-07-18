//
//  StationViewModel.swift
//  TrainTrack
//
//  Created by Archie Edwards on 29/06/2020.
//

import Foundation
import SwiftUI

final class StationViewModel : ObservableObject{
    
    @Published var services : [Service]?
    @Published var alertItem : AlertItem?
    
    public func getLatest(_ stationReq: StationRequest){
        RequestService().getStationUpdate(stationReq) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let services):
                    self.services = services
                case .failure(let error):
                    print("error when getting data for \(stationReq.station?.name ?? "?"): \(error.localizedDescription)") ///TODO make this a log in the future
                    self.alertItem = AlertItem(title: Text("UHOH"), message: Text("Unable to get station data"), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}
