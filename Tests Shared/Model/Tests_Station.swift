//
//  Tests_Station.swift
//  Tests Shared
//
//  Created by Archie Edwards on 01/07/2020.
//

import XCTest

class Tests_Station : XCTestCase{
    
    func testDeparture() throws{
        
        /// read station json from file
        let bundle = Bundle(for: Tests_Station.self)
        guard let stationFileURL = bundle.url(forResource: "TestStation_Departure", withExtension: "json") else {
            return XCTFail("Test failed to find TestStation_Departure.json")
        }
        guard let stationJSON = try? Data(contentsOf: stationFileURL) else {
            return XCTFail("Test failed to convert TestStation_Departure.json to data")
        }
        
        /// decode data
        guard let station = try? JSONDecoder().decode(Station.self, from: stationJSON) else {
            return XCTFail("Test failed to decode station json")
        }
        
        /// assert values
        XCTAssertEqual(station.id, "BWT")
        XCTAssertEqual(station.name, "Bridgwater")
        XCTAssertEqual(station.departures?.all.count, 4)
        XCTAssertEqual(station.arrivals?.all.count, nil)
    }
    
    func testArrival() throws{
        
        /// read station json from file
        let bundle = Bundle(for: Tests_Station.self)
        guard let stationFileURL = bundle.url(forResource: "TestStation_Arrival", withExtension: "json") else {
            return XCTFail("Test failed to find TestStation_Arrival.json")
        }
        guard let stationJSON = try? Data(contentsOf: stationFileURL) else {
            return XCTFail("Test failed to convert TestStation_Arrival.json to data")
        }
        
        /// decode data
        guard let station = try? JSONDecoder().decode(Station.self, from: stationJSON) else {
            return XCTFail("Test failed to decode station json")
        }
        
        /// assert values
        XCTAssertEqual(station.id, "BWT")
        XCTAssertEqual(station.name, "Bridgwater")
        XCTAssertEqual(station.departures?.all.count, nil)
        XCTAssertEqual(station.arrivals?.all.count, 5)
    }
    
    func testSetServices_Departures() throws {
        
        /// initialise station
        var station = Station(id: "BHM", name: "Birmingham", departures: nil, arrivals: nil)
        
        /// call set services
        let services = Services(all: [Service(id: "newService", platform: nil, operatorName: nil, origin: nil, destination: nil, status: nil, aimedDepartureTime: nil, aimedArrivalTime: nil, expDepartureTime: nil, expArrivalTime: nil, expDepartureMins: nil, expArrivalMins: nil)])
        station.setServices(services, type: .departure)
        
        /// assert value changes
        XCTAssertEqual(station.departures?.all.count, 1)
        XCTAssertEqual(station.departures?.all[0].id, "newService")
        
        /// check arrivals is still nil
        if station.arrivals != nil {
            XCTFail("Expected arrivals for station to still be nil after altering departures but was: \(station.arrivals!)")
        }
    }
    
    func testSetServices_Arrivals() throws {
        
        /// initialise station
        var station = Station(id: "BHM", name: "Birmingham", departures: nil, arrivals: nil)
        
        /// call set services
        let services = Services(all: [Service(id: "newService", platform: nil, operatorName: nil, origin: nil, destination: nil, status: nil, aimedDepartureTime: nil, aimedArrivalTime: nil, expDepartureTime: nil, expArrivalTime: nil, expDepartureMins: nil, expArrivalMins: nil)])
        station.setServices(services, type: .arrival)
        
        /// assert value changes
        XCTAssertEqual(station.arrivals?.all.count, 1)
        XCTAssertEqual(station.arrivals?.all[0].id, "newService")
        
        /// check arrivals is still nil
        if station.departures != nil {
            XCTFail("Expected departures for station to still be nil after altering arrivals but was: \(station.departures!)")
        }
    }
    
}
