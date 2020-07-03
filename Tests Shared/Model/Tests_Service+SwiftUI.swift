//
//  Tests_Service+SwiftUI.swift
//  Tests Shared
//
//  Created by Archie Edwards on 05/07/2020.
//

import XCTest

class Tests_Service_SwiftUI : XCTestCase{
    func testExpMinsForProgressBar() throws {
        let service = Service(id: "1", platform: nil, operatorName: nil, origin: nil, destination: nil, status: nil, aimedDepartureTime: nil, aimedArrivalTime: nil, expDepartureTime: nil, expArrivalTime: nil, expDepartureMins: 60, expArrivalMins: 30)
        XCTAssertEqual(service.expMinsForProgressBar(), 0.5)
        XCTAssertEqual(service.expMinsForProgressBar(type: .arrival), 0.75)
    }
    
    func testExpMinsForProgressBar_nil() throws{
        let service = Service(id: "1", platform: nil, operatorName: nil, origin: nil, destination: nil, status: nil, aimedDepartureTime: nil, aimedArrivalTime: nil, expDepartureTime: nil, expArrivalTime: nil, expDepartureMins: nil, expArrivalMins: nil)
        XCTAssertEqual(service.expMinsForProgressBar(), 1)
        XCTAssertEqual(service.expMinsForProgressBar(type: .arrival), 1)
    }
    
    func testExpMinsForProgressBar_EdgeCases() throws {
        let service = Service(id: "1", platform: nil, operatorName: nil, origin: nil, destination: nil, status: nil, aimedDepartureTime: nil, aimedArrivalTime: nil, expDepartureTime: nil, expArrivalTime: nil, expDepartureMins: -1, expArrivalMins: 150)
        XCTAssertEqual(service.expMinsForProgressBar(), 1)
        XCTAssertEqual(service.expMinsForProgressBar(type: .arrival), 0)
    }
    
    func testExpMinsForStatus() throws{
        let service = Service(id: "1", platform: nil, operatorName: nil, origin: nil, destination: nil, status: nil, aimedDepartureTime: nil, aimedArrivalTime: nil, expDepartureTime: nil, expArrivalTime: nil, expDepartureMins: 2, expArrivalMins: 10)
        XCTAssertEqual(service.expMinsForStatus(), "2 mins")
        XCTAssertEqual(service.expMinsForStatus(type: .arrival), "10 mins")
    }
    
    func testExpMinsForStatus_Due() throws{
        let service = Service(id: "1", platform: nil, operatorName: nil, origin: nil, destination: nil, status: nil, aimedDepartureTime: nil, aimedArrivalTime: nil, expDepartureTime: nil, expArrivalTime: nil, expDepartureMins: 0, expArrivalMins: -1)
        XCTAssertEqual(service.expMinsForStatus(), "Due")
        XCTAssertEqual(service.expMinsForStatus(type: .arrival), "Due")
    }
    
    func testExpMinsForStatus_1min() throws{
        let service = Service(id: "1", platform: nil, operatorName: nil, origin: nil, destination: nil, status: nil, aimedDepartureTime: nil, aimedArrivalTime: nil, expDepartureTime: nil, expArrivalTime: nil, expDepartureMins: 1, expArrivalMins: 1)
        XCTAssertEqual(service.expMinsForStatus(), "1 min")
        XCTAssertEqual(service.expMinsForStatus(type: .arrival), "1 min")
    }
    
    func testExpMinsForStatus_roundDown() throws{
        let service = Service(id: "1", platform: nil, operatorName: nil, origin: nil, destination: nil, status: nil, aimedDepartureTime: nil, aimedArrivalTime: nil, expDepartureTime: nil, expArrivalTime: nil, expDepartureMins: 10.5, expArrivalMins: 5.7)
        XCTAssertEqual(service.expMinsForStatus(), "10 mins")
        XCTAssertEqual(service.expMinsForStatus(type: .arrival), "5 mins")
    }
}
