//
//  Test_Station.swift
//  Tests Shared
//
//  Created by Archie Edwards on 01/07/2020.
//

import XCTest

class Test_Station : XCTestCase{
    
    func testDeparture() throws{
        
        /// read station json from file
        let bundle = Bundle(for: Test_Station.self)
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
        let bundle = Bundle(for: Test_Station.self)
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
    
}
