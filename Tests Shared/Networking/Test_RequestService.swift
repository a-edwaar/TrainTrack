//
//  Test_RequestService.swift
//  Tests Shared
//
//  Created by Archie Edwards on 30/06/2020.
//

import XCTest

class Test_RequestService : XCTestCase{
    
    func testGetStationUpdate_failure() throws {
        
        /// create mock to return failure
        class RequestMock : RequestServiceProtocol{
            func getStationUpdate(station: String, type: Type, completion: @escaping (Result<Data, Error>) -> Void) {
                completion(.failure(NetworkError.noData))
            }
        }
        
        /// inject mock and execute request
        var requestResultOptional : Result<Station, Error>?
        let client = RequestService(r: RequestMock())
        client.getStationUpdate(station: "BHM"){ result in
            requestResultOptional = result
        }
        
        /// assert
        guard let requestResult = requestResultOptional else {
            return XCTFail("RequestService result is nil")
        }
        switch requestResult{
        case .success(let station):
            XCTFail("RequestService was meant to return failure but was success with station: \(station)")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, NetworkError.noData.localizedDescription)
        }
    }
    
    func testGetStationUpdate_success_decodeError() throws {
        
        /// create mock to return success from NetworkManager
        class RequestMock : RequestServiceProtocol{
            func getStationUpdate(station: String, type: Type, completion: @escaping (Result<Data, Error>) -> Void) {
                completion(.success(Data("Hello World".utf8)))
            }
        }
        
        /// create mock to return error from json decoder
        class JSONMock : JSONDecoderProtocol{
            func decode(_ type: Station.Type, from data: Data) throws -> Station {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Bang!"))
            }
        }
        
        /// inject mocks
        var requestResultOptional : Result<Station, Error>?
        let client = RequestService(r: RequestMock(), j: JSONMock())
        client.getStationUpdate(station: "BHM"){ result in
            requestResultOptional = result
        }
        
        /// assert
        guard let requestResult = requestResultOptional else {
            return XCTFail("RequestService result is nil")
        }
        switch requestResult{
        case .success(let station):
            XCTFail("RequestService was meant to return failure but was success with station: \(station)")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it isn’t in the correct format.")
        }
        
    }
    
    func testGetStationUpdate_success() throws {
        
        /// create mock to return success from NetworkManager
        class RequestMock : RequestServiceProtocol{
            func getStationUpdate(station: String, type: Type, completion: @escaping (Result<Data, Error>) -> Void) {
                completion(.success(Data("Hello World".utf8)))
            }
        }
        
        /// create mock to return success from json decoder
        class JSONMock : JSONDecoderProtocol{
            func decode(_ type: Station.Type, from data: Data) throws -> Station {
                return Station(id: "BHM", name: nil, departures: nil, arrivals: nil)
            }
        }
        
        /// inject mocks
        var requestResultOptional : Result<Station, Error>?
        let client = RequestService(r: RequestMock(), j: JSONMock())
        client.getStationUpdate(station: "BHM"){ result in
            requestResultOptional = result
        }
        
        /// assert
        guard let requestResult = requestResultOptional else {
            return XCTFail("RequestService result is nil")
        }
        switch requestResult{
        case .success(let station):
            XCTAssertEqual(station.id, "BHM")
        case .failure(let error):
            XCTFail("RequestService was meant to return success but was failure with error: \(error.localizedDescription)")
        }
        
    }
    
}
