//
//  Tests_Service+SwiftUI.swift
//  Tests Shared
//
//  Created by Archie Edwards on 05/07/2020.
//

import XCTest

class Tests_Service_SwiftUI : XCTestCase{
    func testExpMinsForProgressBar() throws {
        let service = Service(id: "id", platform: nil, station: "", status: .onTime, scheduledTime: "", expMins: 60)
        XCTAssertEqual(service.expMinsForProgressBar(), 0.5)
    }
    
    func testExpMinsForProgressBar_Negative() throws {
        let service = Service(id: "id", platform: nil, station: "", status: .onTime, scheduledTime: "", expMins: -2)
        XCTAssertEqual(service.expMinsForProgressBar(), 1)
    }
    
    func testExpMinsForProgressBar_OverTwoHours() throws{
        let service = Service(id: "id", platform: nil, station: "", status: .onTime, scheduledTime: "", expMins: 150)
        XCTAssertEqual(service.expMinsForProgressBar(), 0)
    }
    
    func testExpMinsForStatus() throws{
        let service = Service(id: "id", platform: nil, station: "", status: .onTime, scheduledTime: "", expMins: 2)
        XCTAssertEqual(service.expMinsForStatus(), "2 mins")
    }
    
    func testExpMinsForStatus_Due() throws{
        let service1 = Service(id: "id", platform: nil, station: "", status: .onTime, scheduledTime: "", expMins: 0)
        let service2 = Service(id: "id", platform: nil, station: "", status: .onTime, scheduledTime: "", expMins: -1)
        XCTAssertEqual(service1.expMinsForStatus(), "Due")
        XCTAssertEqual(service2.expMinsForStatus(), "Due")
    }
    
    func testExpMinsForStatus_1min() throws{
        let service = Service(id: "id", platform: nil, station: "", status: .onTime, scheduledTime: "", expMins: 1)
        XCTAssertEqual(service.expMinsForStatus(), "1 min")
    }
}
