//
//  Tests_Status+SwiftUI.swift
//  Tests Shared
//
//  Created by Archie Edwards on 05/07/2020.
//

import XCTest

class Tests_Status_SwiftUI: XCTestCase {
    
    func testStatusGreen() throws {
        XCTAssertEqual(Status.arrived.color, .green)
        XCTAssertEqual(Status.changeOfIdentity.color, .green)
        XCTAssertEqual(Status.changeOfOrigin.color, .green)
        XCTAssertEqual(Status.early.color, .green)
        XCTAssertEqual(Status.noReport.color, .green)
        XCTAssertEqual(Status.offRoute.color, .green)
        XCTAssertEqual(Status.onTime.color, .green)
        XCTAssertEqual(Status.reinstatement.color, .green)
        XCTAssertEqual(Status.startsHere.color, .green)
    }

    func testStatusRed() throws  {
        XCTAssertEqual(Status.cancelled.color, .red)
        XCTAssertEqual(Status.late.color, .red)
    }

}
