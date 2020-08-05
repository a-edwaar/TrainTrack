//
//  IntentHandler.swift
//  TrainTrackIntentsExt
//
//  Created by Archie Edwards on 05/08/2020.
//

import Intents

class IntentHandler: INExtension {
    
    let stations = StationsViewModel().stations
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}

extension IntentHandler: GetLatestServicesIntentHandling{
    
    func provideStationOptionsCollection(for intent: GetLatestServicesIntent, with completion: @escaping (INObjectCollection<IntentStation>?, Error?) -> Void) {
        completion(getStations(), nil)
    }
    
    func provideFilterStationOptionsCollection(for intent: GetLatestServicesIntent, with completion: @escaping (INObjectCollection<IntentStation>?, Error?) -> Void) {
        completion(getStations(), nil)
    }
    
    private func getStations() -> INObjectCollection<IntentStation>{
        /// get list of stations from model in app and convert
//        let stationsToConvert = StationsViewModel().stations
//        var stations = [IntentStation]()
//        for section in stationsToConvert.keys.sorted() {
//            let stationsForKey = stationsToConvert[section]!.map { station in
//                return IntentStation(identifier: station.id, display: station.name)
//            }
//            stations.append(contentsOf: stationsForKey)
//        }
        /// return collection
        return INObjectCollection(items: [IntentStation(identifier: "BHM", display: "Birmingham New Street"), IntentStation(identifier: "BTG", display: "Barnt Green")])
    }
    
    func defaultStation(for intent: GetLatestServicesIntent) -> IntentStation? {
        return IntentStation(identifier: "BHM", display: "Birmingham New Street")
    }
    
    func defaultFilterStation(for intent: GetLatestServicesIntent) -> IntentStation? {
        return IntentStation(identifier: "BTG", display: "Barnt Green")
    }
}
