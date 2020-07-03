//
//  Tests_NetworkError.swift
//  Tests Shared
//
//  Created by Archie Edwards on 30/06/2020.
//

import XCTest

class Tests_NetworkError: XCTestCase {

    func testNoData() throws{
        let noDataError = NetworkError.noData
        XCTAssertEqual(noDataError.localizedDescription, "No data returned from request")
    }

}
