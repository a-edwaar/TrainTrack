//
//  IntentHandler.swift
//  TrainTrackIntentsExt
//
//  Created by Archie Edwards on 05/08/2020.
//

import Intents

class IntentHandler: INExtension {
    
    var stationSections : [INObjectSection<IntentStation>] = []
    
    override init() {
        super.init()
        self.stationSections = loadStationsAndConvert()
    }
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        return self
    }
    
    private func loadStationsAndConvert() -> [INObjectSection<IntentStation>]{
        /// get list of stations from model in app and convert
        let stationsToConvert = StationsViewModel().stations
        var sections = [INObjectSection<IntentStation>]()
        for section in stationsToConvert.keys.sorted() {
            let stationsForKey = stationsToConvert[section]!.map { station in
                return IntentStation(identifier: station.id, display: station.name)
            }
            sections.append(INObjectSection(title: section, items: stationsForKey))
        }
        return sections
    }
}

extension IntentHandler: GetLatestServicesIntentHandling{
    
    func provideDepartingStationOptionsCollection(for intent: GetLatestServicesIntent, with completion: @escaping (INObjectCollection<IntentStation>?, Error?) -> Void) {
        completion(INObjectCollection(sections: stationSections), nil)
    }
    
    func provideCallingStationOptionsCollection(for intent: GetLatestServicesIntent, with completion: @escaping (INObjectCollection<IntentStation>?, Error?) -> Void) {
        completion(INObjectCollection(sections: stationSections), nil)
    }
    
    func provideArrivingStationOptionsCollection(for intent: GetLatestServicesIntent, with completion: @escaping (INObjectCollection<IntentStation>?, Error?) -> Void) {
        completion(INObjectCollection(sections: stationSections), nil)
    }
    
    func provideFromStationOptionsCollection(for intent: GetLatestServicesIntent, with completion: @escaping (INObjectCollection<IntentStation>?, Error?) -> Void) {
        completion(INObjectCollection(sections: stationSections), nil)
    }
    
    /// TODO: make the below try use the nearest station
    
    func defaultDepartingStation(for intent: GetLatestServicesIntent) -> IntentStation? {
        IntentStation(identifier: "BHM", display: "Birmingham New Street")
    }
    
    func defaultArrivingStation(for intent: GetLatestServicesIntent) -> IntentStation? {
        IntentStation(identifier: "BHM", display: "Birmingham New Street")
    }
}
