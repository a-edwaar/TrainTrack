//
//  Tests_RequestService.swift
//  Tests Shared
//
//  Created by Archie Edwards on 30/06/2020.
//

import XCTest

class Tests_RequestService : XCTestCase{
    
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
    
    func testGetStationUpdate_successAndSorted_Departures() throws {
        
        /// create mock to return success from NetworkManager
        class RequestMock : RequestServiceProtocol{
            func getStationUpdate(station: String, type: Type, completion: @escaping (Result<Data, Error>) -> Void) {
                completion(.success(Data("Hello World".utf8)))
            }
        }
        
        /// create mock to return success from json decoder
        class JSONMock : JSONDecoderProtocol{
            
            let unsortedServices = Services(all: [Service(id: "1", platform: nil, operatorName: nil, origin: nil, destination: nil, status: nil, aimedDepartureTime: nil, aimedArrivalTime: nil, expDepartureTime: nil, expArrivalTime: nil, expDepartureMins: 5, expArrivalMins: nil), Service(id: "2", platform: nil, operatorName: nil, origin: nil, destination: nil, status: nil, aimedDepartureTime: nil, aimedArrivalTime: nil, expDepartureTime: nil, expArrivalTime: nil, expDepartureMins: nil, expArrivalMins: nil), Service(id: "3", platform: nil, operatorName: nil, origin: nil, destination: nil, status: nil, aimedDepartureTime: nil, aimedArrivalTime: nil, expDepartureTime: nil, expArrivalTime: nil, expDepartureMins: 2, expArrivalMins: nil), Service(id: "4", platform: nil, operatorName: nil, origin: nil, destination: nil, status: nil, aimedDepartureTime: nil, aimedArrivalTime: nil, expDepartureTime: nil, expArrivalTime: nil, expDepartureMins: 1, expArrivalMins: nil)])
            
            func decode(_ type: Station.Type, from data: Data) throws -> Station {
                return Station(id: "BHM", name: nil, departures: unsortedServices, arrivals: nil)
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
            XCTAssertEqual(station.departures?.all[0].id, "4")
            XCTAssertEqual(station.departures?.all[1].id, "3")
            XCTAssertEqual(station.departures?.all[2].id, "1")
            XCTAssertEqual(station.departures?.all[3].id, "2")
        case .failure(let error):
            XCTFail("RequestService was meant to return success but was failure with error: \(error.localizedDescription)")
        }
        
    }
    
    func testGetStationUpdate_successAndSorted_Arrivals() throws {
        
        /// create mock to return success from NetworkManager
        class RequestMock : RequestServiceProtocol{
            func getStationUpdate(station: String, type: Type, completion: @escaping (Result<Data, Error>) -> Void) {
                completion(.success(Data("Hello World".utf8)))
            }
        }
        
        /// create mock to return success from json decoder
        class JSONMock : JSONDecoderProtocol{
            
            let unsortedServices = Services(all: [Service(id: "1", platform: nil, operatorName: nil, origin: nil, destination: nil, status: nil, aimedDepartureTime: nil, aimedArrivalTime: nil, expDepartureTime: nil, expArrivalTime: nil, expDepartureMins: nil, expArrivalMins: 5), Service(id: "2", platform: nil, operatorName: nil, origin: nil, destination: nil, status: nil, aimedDepartureTime: nil, aimedArrivalTime: nil, expDepartureTime: nil, expArrivalTime: nil, expDepartureMins: nil, expArrivalMins: nil), Service(id: "3", platform: nil, operatorName: nil, origin: nil, destination: nil, status: nil, aimedDepartureTime: nil, aimedArrivalTime: nil, expDepartureTime: nil, expArrivalTime: nil, expDepartureMins: nil, expArrivalMins: 2), Service(id: "4", platform: nil, operatorName: nil, origin: nil, destination: nil, status: nil, aimedDepartureTime: nil, aimedArrivalTime: nil, expDepartureTime: nil, expArrivalTime: nil, expDepartureMins: nil, expArrivalMins: 1)])
            
            func decode(_ type: Station.Type, from data: Data) throws -> Station {
                return Station(id: "BHM", name: nil, departures: nil, arrivals: unsortedServices)
            }
        }
        
        /// inject mocks
        var requestResultOptional : Result<Station, Error>?
        let client = RequestService(r: RequestMock(), j: JSONMock())
        client.getStationUpdate(station: "BHM", type: .arrival){ result in
            requestResultOptional = result
        }
        
        /// assert
        guard let requestResult = requestResultOptional else {
            return XCTFail("RequestService result is nil")
        }
        switch requestResult{
        case .success(let station):
            XCTAssertEqual(station.arrivals?.all[0].id, "4")
            XCTAssertEqual(station.arrivals?.all[1].id, "3")
            XCTAssertEqual(station.arrivals?.all[2].id, "1")
            XCTAssertEqual(station.arrivals?.all[3].id, "2")
        case .failure(let error):
            XCTFail("RequestService was meant to return success but was failure with error: \(error.localizedDescription)")
        }
        
    }
    
}
