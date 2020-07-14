//
//  Tests_Status+SwiftUI.swift
//  Tests Shared
//
//  Created by Archie Edwards on 05/07/2020.
//

import XCTest

class Tests_Status_SwiftUI: XCTestCase {
    
    func testStatusGreen() throws {
        XCTAssertEqual(Status.onTime.color, .green)
        XCTAssertEqual(Status.early.color, .green)
    }

    func testStatusRed() throws {
        XCTAssertEqual(Status.cancelled.color, .red)
        XCTAssertEqual(Status.late.color, .red)
    }
    
    func testStatusOrange() throws {
        XCTAssertEqual(Status.other.color, .orange)
    }

}
