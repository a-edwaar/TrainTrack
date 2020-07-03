//
//  Tests_Type.swift
//  Tests Shared
//
//  Created by Archie Edwards on 30/06/2020.
//

import XCTest

class Tests_Type: XCTestCase {

    func testType_departure() throws {
        let departure = Type.departure
        XCTAssertEqual(departure.rawValue, "departure")
    }
    
    func testType_arrival() throws {
        let departure = Type.arrival
        XCTAssertEqual(departure.rawValue, "arrival")
    }

}
