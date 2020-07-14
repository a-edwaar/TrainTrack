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
    @Published var type: Type = .departure
    
    public func getLatest(_ stationName: String){
        RequestService().getStationUpdate(station: stationName, type: type) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let services):
                    self.services = services
                case .failure(let error):
                    print(error.localizedDescription) ///TODO make this a log in the future
                    self.alertItem = AlertItem(title: Text("UHOH"), message: Text("Unable to get station data"), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}
