//
//  Service.swift
//  TrainTrack
//
//  Created by Archie Edwards on 29/06/2020.
//

import Foundation
import SWXMLHash

public struct RequestService {
    
    private let r : RequestServiceProtocol
    private let d : () -> Date
    
    init(r: RequestServiceProtocol = NetworkManager(), d: @escaping () -> Date = Date.init) {
        self.r = r
        self.d = d
    }
    
    public func getStationUpdate(_ stationReq: StationRequest, completion: @escaping (Result<[Service], Error>) -> Void) {
        r.getStationUpdate(stationReq) { result in
            switch result {
            case .success(let data):
                
                /// parse xml response
                let xml = SWXMLHash.config{ config in
                    config.shouldProcessNamespaces = true
                }.parse(data)
                
                let xmlServices = stationReq.type == .departure ? xml["Envelope"]["Body"]["GetDepartureBoardResponse"]["GetStationBoardResult"]["trainServices"]["service"].all : xml["Envelope"]["Body"]["GetArrivalBoardResponse"]["GetStationBoardResult"]["trainServices"]["service"].all
                
                /// loop through services returned
                var services : [Service] = []
                for service in xmlServices {
                    
                    /// id
                    guard let serviceId = service["serviceID"].element?.text else{
                        continue /// dont include service as always should have id
                    }
                    
                    /// scheduled time
                    guard let scheduledTime = cleanTime(stationReq.type == .departure ? service["std"].element?.text : service["sta"].element?.text) else{
                        continue //// dont include service as should have a scheduled time
                    }
                    
                    /// platform
                    let platform = service["platform"].element?.text
                    
                    /// destination or origin
                    let targetStation = stationReq.type == .departure ? (service["destination"]["location"][0]["locationName"].element?.text) ?? "Unknown" : (service["origin"]["location"][0]["locationName"].element?.text) ?? "Unknown"
                    
                    var status : Status
                    var expMins : Int
                    if service["isCancelled"].element?.text == "true" || service["cancelReason"].element?.text != nil || service["filterLocationCancelled"].element?.text == "true" {
                        status = .cancelled
                        expMins = 120 /// this doesnt matter as it won't be shown
                    }else{
                        let estimatedTime = cleanTime(stationReq.type == .departure ? service["etd"].element?.text : service["eta"].element?.text)
                        if estimatedTime == nil {
                            status = .onTime
                            expMins = calculateExpMins(scheduledTime)
                        }else{
                            status = calculateStatus(scheduledTime: scheduledTime, estimatedTime: estimatedTime!)
                            switch estimatedTime{
                            case "On time", "Cancelled", "Delayed", "No report":
                                expMins = calculateExpMins(scheduledTime) /// estimated value is a string rather than time so use scheduled time
                            default:
                                expMins = calculateExpMins(estimatedTime!)
                            }
                        }
                    }
                    
                    /// add service info to services array
                    services.append(contentsOf: [Service(id: serviceId, platform: platform, station: targetStation, status: status, scheduledTime: scheduledTime, expMins: expMins)])
                }
                completion(.success(services))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func calculateStatus(scheduledTime: String, estimatedTime: String) -> Status{
        switch estimatedTime{
        case "On time":
            return .onTime
        case "Cancelled":
            return .cancelled
        case "Delayed":
            return .late
        case "No report":
            return .other
        default:
            let expScheduledTime = calculateExpMins(scheduledTime)
            let expEstimatedTime = calculateExpMins(estimatedTime)
            if expEstimatedTime > expScheduledTime{
                return .late
            }else if expEstimatedTime < expScheduledTime{
                return .early
            }else{
                return .onTime
            }
        }
    }
    
    private func calculateExpMins(_ estimate: String) -> Int {
        /// format into date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        guard let comparedDate = dateFormatter.date(from: estimate) else{
            return 120
        }

        /// calculate diff from current date
        let calendar = Calendar.current
        let currentDate = d()
        let compareComponents = calendar.dateComponents([.hour, .minute], from: comparedDate)
        let currentComponents = calendar.dateComponents([.hour, .minute], from: currentDate)
        guard let difference = calendar.dateComponents([.minute], from: currentComponents, to: compareComponents).minute else{
            return 120
        }
        return difference
    }
    
    private func cleanTime(_ time: String?) -> String?{
        if time == nil{
            return time
        }
        var tmp = time!
        if tmp.contains("*") {
            tmp.removeAll(where: { char in
                char == "*"
            })
        }
        return tmp
    }
}
