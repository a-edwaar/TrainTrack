//
//  URLRequest+transportapi.swift
//  TrainTrack
//
//  Created by Archie Edwards on 28/06/2020.
//

import Foundation

extension URLRequest{
    
    private static var baseURL: String { "https://transportapi.com/v3/uk/train" }
    private static var appID : String { "7ae3a91e" }
    private static var appKey : String { "adf9357ab2ed1ddc3945be4be1ce896d" }
    private static var creds : String { formParams(params: "?app_id=\(appID)", "app_key=\(appKey)&") }
    
    public static func station(station: String, type : Type = .departure) -> URLRequest {
        let darwin = true
        let trainStatus = "passenger"
        let params = formParams(params: "darwin=\(darwin)", "train_status=\(trainStatus)", "type=\(type)")
        let endpoint = formEndpoint(endpoint: "station", station, "live.json")
        return .init(endpoint: endpoint, params: params)
    }
    
    public static func getBaseURL() -> String {
        return baseURL
    }
    
    public static func formParams(params: String...) -> String {
        return params.joined(separator: "&")
    }
    
    public static func formEndpoint(endpoint: String...) -> String {
        return baseURL + "/" + endpoint.joined(separator: "/")
    }

    init(endpoint: String = baseURL, params: String = "") {
        guard let url = URL(string: endpoint + URLRequest.creds + params) else {
            preconditionFailure("Expected a valid URL")
        }
        self.init(url: url)
    }
}
