//
//  StationsViewModel.swift
//  TrainTrack
//
//  Created by Archie Edwards on 14/07/2020.
//

import Foundation
import SwiftUI

final class StationsViewModel {
    
    var stations = [String:[Station]]()
    
    init() {
        
        /// read in stations csv
        guard let path = Bundle.main.path(forResource: "station_codes", ofType: "csv") else {
            return
        }
        do {
            let stationsFile = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            var splitbycomma = [String]()
            var stationsArray = [Station]()
            stationsFile.enumerateLines { station, _ in
                splitbycomma = station.components(separatedBy: ",")
                stationsArray.append(Station(id: splitbycomma[1], name: splitbycomma[0]))
            }
            /// group stations into dictionary alphabetically with first char
            stations = Dictionary(grouping: stationsArray, by: {
                String($0.name.prefix(1))
            })
        } catch {
            fatalError()
        }
    }
}
