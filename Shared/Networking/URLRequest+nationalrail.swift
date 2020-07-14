//
//  URLRequest+nationalrail.swift
//  TrainTrack
//
//  Created by Archie Edwards on 28/06/2020.
//

import Foundation

extension URLRequest{
    
    private static var baseURL: String { "https://lite.realtime.nationalrail.co.uk/OpenLDBWS/ldb11.asmx" }
    private static var appToken : String { "fb13b19b-f39e-47d6-88a7-75d4156a6acb" }
    
    public static func station(stationReq: StationRequest) -> URLRequest {
        let parameters = ["numRows": "150", "crs": stationReq.station?.id ?? "", "filterCrs": stationReq.filterStation?.id ?? ""]
        return formSoapRequest(stationReq.type == .departure ? "GetDepartureBoardRequest" : "GetArrivalBoardRequest", parameters: parameters)
    }
    
    private static func formSoapRequest(_ request: String, parameters: [String: String]) -> URLRequest {
        var paramLines = [String]()
        for (key, value) in parameters {
            paramLines.append("<ns1:\(key)>\(value)</ns1:\(key)>")
        }
        let paramString = paramLines.joined()
        let soapMessage = """
        <SOAP-ENV:Envelope
        xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
        xmlns:ns1="http://thalesgroup.com/RTTI/2017-10-01/ldb/"
        xmlns:ns2="http://thalesgroup.com/RTTI/2010-11-01/ldb/commontypes">
        <SOAP-ENV:Header>
        <ns2:AccessToken>
        <ns2:TokenValue>\(appToken)</ns2:TokenValue>
        </ns2:AccessToken>
        </SOAP-ENV:Header>
        <SOAP-ENV:Body>
        <ns1:\(request)>\(paramString)</ns1:\(request)>
        </SOAP-ENV:Body>
        </SOAP-ENV:Envelope>
        """
        guard let url = URL(string: baseURL) else {
            preconditionFailure("Expected a valid URL")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(String(soapMessage.count), forHTTPHeaderField: "Content-Length")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = soapMessage.data(using: .utf8, allowLossyConversion: false)
        return urlRequest
    }
    
    public static func getBaseURL() -> String {
        return baseURL
    }
}
