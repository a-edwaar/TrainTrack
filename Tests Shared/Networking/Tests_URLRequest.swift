//
//  Tests_URLRequest.swift
//  Tests Shared
//
//  Created by Archie Edwards on 30/06/2020.
//

import XCTest

class Tests_URLRequest: XCTestCase {

    func testURLRequest_baseURL() throws {
        let actualURL = URLRequest.getBaseURL()
        let expectedURL = "https://lite.realtime.nationalrail.co.uk/OpenLDBWS/ldb11.asmx"
        XCTAssertEqual(actualURL, expectedURL)
    }
    
    func testURLRequest_Station_departure() throws {
        
        let actualURL = URLRequest.station(station: "BHM")
        let actualBody = String(decoding: actualURL.httpBody!, as: UTF8.self)
        
        let expectedURL = URL(string: "https://lite.realtime.nationalrail.co.uk/OpenLDBWS/ldb11.asmx")
            
        /// due to parameters bieng passed in as a map in URLRequest.station() ... can't compare fully bodies as they won't always be the same order
        XCTAssertEqual(actualURL.url, expectedURL)
        XCTAssert(actualBody.contains("<ns1:GetDepartureBoardRequest>"))
        XCTAssert(actualBody.contains("<ns1:crs>BHM</ns1:crs>"))
        XCTAssert(actualBody.contains("<ns1:numRows>150</ns1:numRows>"))
        XCTAssert(actualBody.contains("<ns1:filterCrs></ns1:filterCrs>"))
        XCTAssert(actualBody.contains("</ns1:GetDepartureBoardRequest>"))
    }
    
    func testURLRequest_Station_arrival() throws {
        
        let actualURL = URLRequest.station(station: "BHM", type: .arrival)
        let actualBody = String(decoding: actualURL.httpBody!, as: UTF8.self)
        
        let expectedURL = URL(string: "https://lite.realtime.nationalrail.co.uk/OpenLDBWS/ldb11.asmx")
            
        /// due to parameters bieng passed in as a map in URLRequest.station() ... can't compare fully bodies as they won't always be the same order
        XCTAssertEqual(actualURL.url, expectedURL)
        XCTAssert(actualBody.contains("<ns1:GetArrivalBoardRequest>"))
        XCTAssert(actualBody.contains("<ns1:crs>BHM</ns1:crs>"))
        XCTAssert(actualBody.contains("<ns1:numRows>150</ns1:numRows>"))
        XCTAssert(actualBody.contains("<ns1:filterCrs></ns1:filterCrs>"))
        XCTAssert(actualBody.contains("</ns1:GetArrivalBoardRequest>"))
    }

}
