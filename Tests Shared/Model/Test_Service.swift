//
//  Test_Service.swift
//  Tests Shared
//
//  Created by Archie Edwards on 01/07/2020.
//

import XCTest

class Test_Service : XCTestCase{
    
    func testDeparture() throws {
        
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
        
        /// assert
        guard let serviceToTest = station.departures?.all[0] else{
            return XCTFail("Expected there to be a departure for station")
        }
        
        XCTAssertEqual(serviceToTest.id, "L83237")
        XCTAssertEqual(serviceToTest.platform, nil)
        XCTAssertEqual(serviceToTest.operatorName, "Great Western Railway")
        XCTAssertEqual(serviceToTest.origin, "Taunton")
        XCTAssertEqual(serviceToTest.destination, "Cardiff Central")
        XCTAssertEqual(serviceToTest.aimedDepartureTime, "17:21")
        XCTAssertEqual(serviceToTest.aimedArrivalTime, "17:20")
        XCTAssertEqual(serviceToTest.expDepartureMins, 27)
        XCTAssertEqual(serviceToTest.expArrivalMins, 26)
        XCTAssertEqual(serviceToTest.expDepartureTime, "17:21")
        XCTAssertEqual(serviceToTest.expArrivalTime, "17:20")
        XCTAssertEqual(serviceToTest.status, Status.onTime)
        
    }
    
    func testArrival(){
        
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
        
        /// assert
        guard let serviceToTest = station.arrivals?.all[0] else{
            return XCTFail("Expected there to be a departure for station")
        }
        
        XCTAssertEqual(serviceToTest.id, "L82367")
        XCTAssertEqual(serviceToTest.platform, nil)
        XCTAssertEqual(serviceToTest.operatorName, "Great Western Railway")
        XCTAssertEqual(serviceToTest.origin, "Cardiff Central")
        XCTAssertEqual(serviceToTest.destination, "Taunton")
        XCTAssertEqual(serviceToTest.aimedDepartureTime, "17:48")
        XCTAssertEqual(serviceToTest.aimedArrivalTime, "17:48")
        XCTAssertEqual(serviceToTest.expDepartureMins, 19)
        XCTAssertEqual(serviceToTest.expArrivalMins, 19)
        XCTAssertEqual(serviceToTest.expArrivalTime, "17:48")
        XCTAssertEqual(serviceToTest.expArrivalTime, "17:48")
        XCTAssertEqual(serviceToTest.status, Status.noReport)
        
    }
}
