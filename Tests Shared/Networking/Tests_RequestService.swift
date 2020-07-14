//
//  Tests_RequestService.swift
//  Tests Shared
//
//  Created by Archie Edwards on 30/06/2020.
//

import Foundation
import XCTest

class Tests_RequestService : XCTestCase{
    
    enum TestRequestServiceError: Error {
        
        case notFound
        case failedToConvert
        
        public var errorDescription: String? {
            switch self {
            case .notFound:
                return NSLocalizedString("Test failed to find file", comment: "Not found")
            default:
                return NSLocalizedString("Test failed to convert xml to data", comment: "Failed to convert")
            }
        }
    }
    
    func loadXmlHelper(file: String) -> Result<Data,Error>{
        let bundle = Bundle(for: Tests_RequestService.self)
        guard let stationFileURL = bundle.url(forResource: file, withExtension: "xml") else {
            return .failure(TestRequestServiceError.notFound)
        }
        guard let stationData = try? Data(contentsOf: stationFileURL) else {
            return .failure(TestRequestServiceError.failedToConvert)
        }
        return .success(stationData)
    }
    
    override func setUpWithError() throws {
        /// want to stop execution if we fail to load xml file
        continueAfterFailure = false
    }
    
    func testGetStationUpdate_failure() throws {
        
        /// create mock to return failure
        class RequestMock : RequestServiceProtocol{
            func getStationUpdate(_ stationReq: StationRequest, completion: @escaping (Result<Data, Error>) -> Void) {
                completion(.failure(NetworkError.noData))
            }
        }
        
        /// inject mock and execute request
        var requestResultOptional : Result<[Service], Error>?
        let client = RequestService(r: RequestMock())
        client.getStationUpdate(StationRequest(station: nil, filterStation: nil, type: .departure)){ result in
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
    
    func testGetStationUpdate_success_badData() throws {

        /// create mock to return success from NetworkManager
        class RequestMock : RequestServiceProtocol{
            func getStationUpdate(_ stationReq: StationRequest, completion: @escaping (Result<Data, Error>) -> Void) {
                completion(.success(Data("Hello World".utf8)))
            }
        }

        /// inject mock
        var requestResultOptional : Result<[Service], Error>?
        let client = RequestService(r: RequestMock())
        client.getStationUpdate(StationRequest(station: nil, filterStation: nil, type: .departure)){ result in
            requestResultOptional = result
        }

        /// assert
        guard let requestResult = requestResultOptional else {
            return XCTFail("RequestService result is nil")
        }
        switch requestResult{
        case .success(let services):
            XCTAssertEqual(services.count, 0)
        case .failure(let error):
            XCTFail("RequestService was meant to return success but was failure with error: \(error.localizedDescription)")
        }

    }
    
    func testGetStationUpdate_success_noServices() throws {
        
        let loadXmlResult = loadXmlHelper(file: "RequestService_noServices")
        var stationData : Data?
        switch loadXmlResult {
        case .success(let data):
            stationData = data
        case .failure(let err):
            XCTFail(err.localizedDescription)
        }
        
        /// create mock to return success from NetworkManager
        class RequestMock : RequestServiceProtocol{
            
            var stationData : Data
            
            init(_ stationData : Data) {
                self.stationData = stationData
            }
            
            func getStationUpdate(_ stationReq: StationRequest, completion: @escaping (Result<Data, Error>) -> Void) {
                completion(.success(stationData))
            }
        }

        /// inject mock
        var requestResultOptional : Result<[Service], Error>?
        let client = RequestService(r: RequestMock(stationData!))
        client.getStationUpdate(StationRequest(station: nil, filterStation: nil, type: .departure)){ result in
            requestResultOptional = result
        }

        /// assert
        guard let requestResult = requestResultOptional else {
            return XCTFail("RequestService result is nil")
        }
        switch requestResult{
        case .success(let services):
            XCTAssertEqual(services.count, 0)
        case .failure(let error):
            XCTFail("RequestService was meant to return success but was failure with error: \(error.localizedDescription)")
        }

    }
    
    func testGetStationUpdate_success_noIDorScheduledTime() throws {
        
        let loadXmlResult = loadXmlHelper(file: "RequestService_noIDorScheduledTime")
        var stationData : Data?
        switch loadXmlResult {
        case .success(let data):
            stationData = data
        case .failure(let err):
            XCTFail(err.localizedDescription)
        }
        
        /// create mock to return success from NetworkManager
        class RequestMock : RequestServiceProtocol{
            
            var stationData : Data
            
            init(_ stationData : Data) {
                self.stationData = stationData
            }
            
            func getStationUpdate(_ stationReq: StationRequest, completion: @escaping (Result<Data, Error>) -> Void) {
                completion(.success(stationData))
            }
        }

        /// inject mock
        var requestResultOptional : Result<[Service], Error>?
        let client = RequestService(r: RequestMock(stationData!))
        client.getStationUpdate(StationRequest(station: nil, filterStation: nil, type: .departure)){ result in
            requestResultOptional = result
        }

        /// assert
        guard let requestResult = requestResultOptional else {
            return XCTFail("RequestService result is nil")
        }
        switch requestResult{
        case .success(let services):
            XCTAssertEqual(services.count, 0)
        case .failure(let error):
            XCTFail("RequestService was meant to return success but was failure with error: \(error.localizedDescription)")
        }

    }
    
    func testGetStationUpdate_success_ID() throws {
        
        let loadXmlResult = loadXmlHelper(file: "RequestService_departures")
        var stationData : Data?
        switch loadXmlResult {
        case .success(let data):
            stationData = data
        case .failure(let err):
            XCTFail(err.localizedDescription)
        }
        
        /// create mock to return success from NetworkManager
        class RequestMock : RequestServiceProtocol{
            
            var stationData : Data
            
            init(_ stationData : Data) {
                self.stationData = stationData
            }
            
            func getStationUpdate(_ stationReq: StationRequest, completion: @escaping (Result<Data, Error>) -> Void) {
                completion(.success(stationData))
            }
        }

        /// inject mock
        var requestResultOptional : Result<[Service], Error>?
        let client = RequestService(r: RequestMock(stationData!))
        client.getStationUpdate(StationRequest(station: nil, filterStation: nil, type: .departure)){ result in
            requestResultOptional = result
        }

        /// assert
        guard let requestResult = requestResultOptional else {
            return XCTFail("RequestService result is nil")
        }
        switch requestResult{
        case .success(let services):
            XCTAssertEqual(services[0].id, "o25NR2kZIrOJqTMuX9cChQ==")
            XCTAssertEqual(services[1].id, "LpaunDe7uA5t9QYBsKvnew==")
            XCTAssertEqual(services[2].id, "fYrw6VlobXqDCYva/3XokA==")
        case .failure(let error):
            XCTFail("RequestService was meant to return success but was failure with error: \(error.localizedDescription)")
        }

    }
    
    func testGetStationUpdate_success_scheduledTime_departure() throws {
        
        let loadXmlResult = loadXmlHelper(file: "RequestService_departures")
        var stationData : Data?
        switch loadXmlResult {
        case .success(let data):
            stationData = data
        case .failure(let err):
            XCTFail(err.localizedDescription)
        }
        
        /// create mock to return success from NetworkManager
        class RequestMock : RequestServiceProtocol{
            
            var stationData : Data
            
            init(_ stationData : Data) {
                self.stationData = stationData
            }
            
            func getStationUpdate(_ stationReq: StationRequest, completion: @escaping (Result<Data, Error>) -> Void) {
                completion(.success(stationData))
            }
        }

        /// inject mock
        var requestResultOptional : Result<[Service], Error>?
        let client = RequestService(r: RequestMock(stationData!))
        client.getStationUpdate(StationRequest(station: nil, filterStation: nil, type: .departure)){ result in
            requestResultOptional = result
        }

        /// assert
        guard let requestResult = requestResultOptional else {
            return XCTFail("RequestService result is nil")
        }
        switch requestResult{
        case .success(let services):
            XCTAssertEqual(services[0].scheduledTime, "14:15")
            XCTAssertEqual(services[1].scheduledTime, "14:27")
            XCTAssertEqual(services[2].scheduledTime, "14:35")
        case .failure(let error):
            XCTFail("RequestService was meant to return success but was failure with error: \(error.localizedDescription)")
        }

    }
    
    func testGetStationUpdate_success_scheduledTime_arrival() throws {
        
        let loadXmlResult = loadXmlHelper(file: "RequestService_arrivals")
        var stationData : Data?
        switch loadXmlResult {
        case .success(let data):
            stationData = data
        case .failure(let err):
            XCTFail(err.localizedDescription)
        }
        
        /// create mock to return success from NetworkManager
        class RequestMock : RequestServiceProtocol{
            
            var stationData : Data
            
            init(_ stationData : Data) {
                self.stationData = stationData
            }
            
            func getStationUpdate(_ stationReq: StationRequest, completion: @escaping (Result<Data, Error>) -> Void) {
                completion(.success(stationData))
            }
        }

        /// inject mock
        var requestResultOptional : Result<[Service], Error>?
        let client = RequestService(r: RequestMock(stationData!))
        client.getStationUpdate(StationRequest(station: nil, filterStation: nil, type: .arrival)){ result in
            requestResultOptional = result
        }

        /// assert
        guard let requestResult = requestResultOptional else {
            return XCTFail("RequestService result is nil")
        }
        switch requestResult{
        case .success(let services):
            XCTAssertEqual(services[0].scheduledTime, "14:46")
            XCTAssertEqual(services[1].scheduledTime, "14:51")
            XCTAssertEqual(services[2].scheduledTime, "14:54")
        case .failure(let error):
            XCTFail("RequestService was meant to return success but was failure with error: \(error.localizedDescription)")
        }

    }
    
    func testGetStationUpdate_success_platform() throws {
        
        let loadXmlResult = loadXmlHelper(file: "RequestService_departures")
        var stationData : Data?
        switch loadXmlResult {
        case .success(let data):
            stationData = data
        case .failure(let err):
            XCTFail(err.localizedDescription)
        }
        
        /// create mock to return success from NetworkManager
        class RequestMock : RequestServiceProtocol{
            
            var stationData : Data
            
            init(_ stationData : Data) {
                self.stationData = stationData
            }
            
            func getStationUpdate(_ stationReq: StationRequest, completion: @escaping (Result<Data, Error>) -> Void) {
                completion(.success(stationData))
            }
        }

        /// inject mock
        var requestResultOptional : Result<[Service], Error>?
        let client = RequestService(r: RequestMock(stationData!))
        client.getStationUpdate(StationRequest(station: nil, filterStation: nil, type: .departure)){ result in
            requestResultOptional = result
        }

        /// assert
        guard let requestResult = requestResultOptional else {
            return XCTFail("RequestService result is nil")
        }
        switch requestResult{
        case .success(let services):
            XCTAssertEqual(services[0].platform, nil)
            XCTAssertEqual(services[1].platform, nil)
            XCTAssertEqual(services[2].platform, "8")
        case .failure(let error):
            XCTFail("RequestService was meant to return success but was failure with error: \(error.localizedDescription)")
        }

    }
    
    func testGetStationUpdate_success_station_departure() throws {
        
        let loadXmlResult = loadXmlHelper(file: "RequestService_departures")
        var stationData : Data?
        switch loadXmlResult {
        case .success(let data):
            stationData = data
        case .failure(let err):
            XCTFail(err.localizedDescription)
        }
        
        /// create mock to return success from NetworkManager
        class RequestMock : RequestServiceProtocol{
            
            var stationData : Data
            
            init(_ stationData : Data) {
                self.stationData = stationData
            }
            
            func getStationUpdate(_ stationReq: StationRequest, completion: @escaping (Result<Data, Error>) -> Void) {
                completion(.success(stationData))
            }
        }

        /// inject mock
        var requestResultOptional : Result<[Service], Error>?
        let client = RequestService(r: RequestMock(stationData!))
        client.getStationUpdate(StationRequest(station: nil, filterStation: nil, type: .departure)){ result in
            requestResultOptional = result
        }

        /// assert
        guard let requestResult = requestResultOptional else {
            return XCTFail("RequestService result is nil")
        }
        switch requestResult{
        case .success(let services):
            XCTAssertEqual(services[0].station, "Four Oaks")
            XCTAssertEqual(services[1].station, "Walsall")
            XCTAssertEqual(services[2].station, "Unknown")
        case .failure(let error):
            XCTFail("RequestService was meant to return success but was failure with error: \(error.localizedDescription)")
        }

    }
    
    func testGetStationUpdate_success_station_arrival() throws {
        
        let loadXmlResult = loadXmlHelper(file: "RequestService_arrivals")
        var stationData : Data?
        switch loadXmlResult {
        case .success(let data):
            stationData = data
        case .failure(let err):
            XCTFail(err.localizedDescription)
        }
        
        /// create mock to return success from NetworkManager
        class RequestMock : RequestServiceProtocol{
            
            var stationData : Data
            
            init(_ stationData : Data) {
                self.stationData = stationData
            }
            
            func getStationUpdate(_ stationReq: StationRequest, completion: @escaping (Result<Data, Error>) -> Void) {
                completion(.success(stationData))
            }
        }

        /// inject mock
        var requestResultOptional : Result<[Service], Error>?
        let client = RequestService(r: RequestMock(stationData!))
        client.getStationUpdate(StationRequest(station: nil, filterStation: nil, type: .arrival)){ result in
            requestResultOptional = result
        }

        /// assert
        guard let requestResult = requestResultOptional else {
            return XCTFail("RequestService result is nil")
        }
        switch requestResult{
        case .success(let services):
            XCTAssertEqual(services[0].station, "London Euston")
            XCTAssertEqual(services[1].station, "Crewe")
            XCTAssertEqual(services[2].station, "Unknown")
        case .failure(let error):
            XCTFail("RequestService was meant to return success but was failure with error: \(error.localizedDescription)")
        }

    }
    
    func testGetStationUpdate_success_cancelled() throws {
        
        let loadXmlResult = loadXmlHelper(file: "RequestService_cancelled")
        var stationData : Data?
        switch loadXmlResult {
        case .success(let data):
            stationData = data
        case .failure(let err):
            XCTFail(err.localizedDescription)
        }
        
        /// create mock to return success from NetworkManager
        class RequestMock : RequestServiceProtocol{
            
            var stationData : Data
            
            init(_ stationData : Data) {
                self.stationData = stationData
            }
            
            func getStationUpdate(_ stationReq: StationRequest, completion: @escaping (Result<Data, Error>) -> Void) {
                completion(.success(stationData))
            }
        }

        /// inject mock
        var requestResultOptional : Result<[Service], Error>?
        let client = RequestService(r: RequestMock(stationData!))
        client.getStationUpdate(StationRequest(station: nil, filterStation: nil, type: .departure)){ result in
            requestResultOptional = result
        }

        /// assert
        guard let requestResult = requestResultOptional else {
            return XCTFail("RequestService result is nil")
        }
        switch requestResult{
        case .success(let services):
            XCTAssertEqual(services[0].status, .cancelled)
            XCTAssertEqual(services[0].expMins, 120)
            XCTAssertEqual(services[1].status, .cancelled)
            XCTAssertEqual(services[1].expMins, 120)
            XCTAssertEqual(services[2].status, .cancelled)
            XCTAssertEqual(services[2].expMins, 120)
        case .failure(let error):
            XCTFail("RequestService was meant to return success but was failure with error: \(error.localizedDescription)")
        }

    }
    
    func testGetStationUpdate_success_estimatedTime_departure() throws {
        
        let loadXmlResult = loadXmlHelper(file: "RequestService_departures")
        var stationData : Data?
        switch loadXmlResult {
        case .success(let data):
            stationData = data
        case .failure(let err):
            XCTFail(err.localizedDescription)
        }
        
        /// create mock to return success from NetworkManager
        class RequestMock : RequestServiceProtocol{
            
            var stationData : Data
            
            init(_ stationData : Data) {
                self.stationData = stationData
            }
            
            func getStationUpdate(_ stationReq: StationRequest, completion: @escaping (Result<Data, Error>) -> Void) {
                completion(.success(stationData))
            }
        }
        
        /// mock current date
        class DateMock {
            static func generateDate() -> Date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                guard let date = dateFormatter.date(from: "14:10") else{
                    return Date()
                }
                return date
            }
        }

        /// inject mocks
        var requestResultOptional : Result<[Service], Error>?
        let client = RequestService(r: RequestMock(stationData!), d: DateMock.generateDate)
        client.getStationUpdate(StationRequest(station: nil, filterStation: nil, type: .departure)){ result in
            requestResultOptional = result
        }

        /// assert
        guard let requestResult = requestResultOptional else {
            return XCTFail("RequestService result is nil")
        }
        switch requestResult{
        case .success(let services):
            XCTAssertEqual(services[0].status, .onTime) /// no etd
            XCTAssertEqual(services[0].expMins, 5)
            XCTAssertEqual(services[1].status, .early) /// early etd
            XCTAssertEqual(services[1].expMins, 10)
            XCTAssertEqual(services[2].status, .onTime) /// etd is a status rather than time
            XCTAssertEqual(services[2].expMins, 25)
            XCTAssertEqual(services[3].status, .late) /// etd is delayed and scheduled is in past  -> would be "due" in the view
            XCTAssertEqual(services[3].expMins, -2)
        case .failure(let error):
            XCTFail("RequestService was meant to return success but was failure with error: \(error.localizedDescription)")
        }

    }
    
    func testGetStationUpdate_success_estimatedTime_arrival() throws {
        
        let loadXmlResult = loadXmlHelper(file: "RequestService_arrivals")
        var stationData : Data?
        switch loadXmlResult {
        case .success(let data):
            stationData = data
        case .failure(let err):
            XCTFail(err.localizedDescription)
        }
        
        /// create mock to return success from NetworkManager
        class RequestMock : RequestServiceProtocol{
            
            var stationData : Data
            
            init(_ stationData : Data) {
                self.stationData = stationData
            }
            
            func getStationUpdate(_ stationReq: StationRequest, completion: @escaping (Result<Data, Error>) -> Void) {
                completion(.success(stationData))
            }
        }
        
        /// mock current date
        class DateMock {
            static func generateDate() -> Date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                guard let date = dateFormatter.date(from: "14:40") else{
                    return Date()
                }
                return date
            }
        }

        /// inject mocks
        var requestResultOptional : Result<[Service], Error>?
        let client = RequestService(r: RequestMock(stationData!), d: DateMock.generateDate)
        client.getStationUpdate(StationRequest(station: nil, filterStation: nil, type: .arrival)){ result in
            requestResultOptional = result
        }

        /// assert
        guard let requestResult = requestResultOptional else {
            return XCTFail("RequestService result is nil")
        }
        switch requestResult{
        case .success(let services):
            XCTAssertEqual(services[0].status, .onTime)
            XCTAssertEqual(services[0].expMins, 6)
            XCTAssertEqual(services[1].status, .late)
            XCTAssertEqual(services[1].expMins, 12)
            XCTAssertEqual(services[2].status, .onTime)
            XCTAssertEqual(services[2].expMins, 14)
            XCTAssertEqual(services[3].status, .late)
            XCTAssertEqual(services[3].expMins, -10)
        case .failure(let error):
            XCTFail("RequestService was meant to return success but was failure with error: \(error.localizedDescription)")
        }

    }
}
