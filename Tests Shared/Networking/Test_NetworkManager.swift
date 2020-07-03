//
//  Test_NetworkManager.swift
//  Tests Shared
//
//  Created by Archie Edwards on 30/06/2020.
//

import XCTest

class Test_NetworkManager : XCTestCase {
    
    func testExecuteRequest_failure_error() throws {
        
        /// create mock to return error
        class NetworkMock : NetworkManagerProtocol{
            func executeRequest(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
                completion(nil, NetworkError.noData)
            }
        }
        
        /// inject mock and execute request
        var networkResultOptional : Result<Data, Error>?
        let client = NetworkManager(p: NetworkMock())
        client.executeRequest(request: URLRequest.station(station: "BHM")){ result in
            networkResultOptional = result
        }
        
        /// assert
        guard let networkResult = networkResultOptional else {
            return XCTFail("NetworkManager Result is nil")
        }
        switch networkResult{
        case .success(let data):
            return XCTFail("NetworkManager was meant to fail with a noData error but returned success with data \(data)")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, NetworkError.noData.localizedDescription)
        }
        
    }
    
    func testExecuteRequest_failure_noData() throws {
        
        /// create mock to return nil
        class NetworkMock : NetworkManagerProtocol{
            func executeRequest(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
                completion(nil, nil)
            }
        }
        
        /// inject mock and execute request
        var networkResultOptional : Result<Data, Error>?
        let client = NetworkManager(p: NetworkMock())
        client.executeRequest(request: URLRequest.station(station: "BHM")){ result in
            networkResultOptional = result
        }
        
        /// assert
        guard let networkResult = networkResultOptional else {
            return XCTFail("NetworkManager Result is nil")
        }
        switch networkResult{
        case .success(let data):
            return XCTFail("NetworkManager was meant to fail with a noData error but returned success with data \(data)")
        case .failure(let error):
            XCTAssertEqual(error.localizedDescription, NetworkError.noData.localizedDescription)
        }
        
    }
    
    func testExecuteRequest_success() throws {
        
        /// create mock to return data
        class NetworkMock : NetworkManagerProtocol{
            func executeRequest(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
                completion(Data("Hello world".utf8), nil)
            }
        }
        
        /// inject mock and execute request
        var networkResultOptional : Result<Data, Error>?
        let client = NetworkManager(p: NetworkMock())
        client.executeRequest(request: URLRequest.station(station: "BHM")){ result in
            networkResultOptional = result
        }
        
        /// assert
        guard let networkResult = networkResultOptional else {
            return XCTFail("NetworkManager Result is nil")
        }
        switch networkResult{
        case .success(let data):
            XCTAssertEqual(String(decoding: data, as: UTF8.self), "Hello world")
        case .failure(let error):
            return XCTFail("NetworkManager was meant to succeed but failed with error: \(error.localizedDescription)")
        }
        
    }
    
}
