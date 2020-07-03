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
        let expectedURL = "https://transportapi.com/v3/uk/train"
        XCTAssertEqual(actualURL, expectedURL)
    }
    
    func testURLRequest_formEndpoint_noExtra() throws {
        let actualEndpoint = URLRequest.formEndpoint(endpoint: "")
        let expectedEndpoint = "https://transportapi.com/v3/uk/train/"
        XCTAssertEqual(actualEndpoint, expectedEndpoint)
    }
    
    func testURLRequest_formEndpoint_extra() throws {
        let actualEndpoint = URLRequest.formEndpoint(endpoint: "blah1", "blah2", "blah3")
        let expectedEndpoint = "https://transportapi.com/v3/uk/train/blah1/blah2/blah3"
        XCTAssertEqual(actualEndpoint, expectedEndpoint)
    }
    
    func testURLRequest_formParams_noExtra() throws {
        let actualParams = URLRequest.formParams(params: "")
        let expectedParams = ""
        XCTAssertEqual(actualParams, expectedParams)
    }
    
    func testURLRequest_formParams_extra() throws {
        let actualParams = URLRequest.formParams(params: "blah1", "blah2", "blah3")
        let expectedParams = "blah1&blah2&blah3"
        XCTAssertEqual(actualParams, expectedParams)
    }
    
    func testURLRequest_Station_departure() throws {
        let actualURL = URLRequest.station(station: "BHM")
        let expectedURL = URL(string: "https://transportapi.com/v3/uk/train/station/BHM/live.json?app_id=7ae3a91e&app_key=adf9357ab2ed1ddc3945be4be1ce896d&darwin=true&train_status=passenger&type=departure")
        XCTAssertEqual(actualURL, URLRequest(url: expectedURL!))
    }
    
    func testURLRequest_Station_arrival() throws {
        let actualURL = URLRequest.station(station: "BHM", type: .arrival)
        let expectedURL = URL(string: "https://transportapi.com/v3/uk/train/station/BHM/live.json?app_id=7ae3a91e&app_key=adf9357ab2ed1ddc3945be4be1ce896d&darwin=true&train_status=passenger&type=arrival")
        XCTAssertEqual(actualURL, URLRequest(url: expectedURL!))
    }

}
