//
//  ServicesForStationView.swift
//  TrainTrack
//
//  Created by Archie Edwards on 29/06/2020.
//

import SwiftUI

struct ServicesForStationView: View {
    
    var stationReq : StationRequest
    var services : [Service]
    
    var body: some View{
        VStack{
            if services.count > 0 {
                List {
                    ForEach(services) { service in
                        ServiceView(service: service)
                    }
                }
            }else{
                Spacer()
                Text("No \(stationReq.type.rawValue) found \(stationReq.type == .departure ? "from" : "to") \(stationReq.station?.name ?? "Unknown")")
                    .foregroundColor(.secondary)
                Spacer()
            }
        }.navigationBarTitle(stationReq.station?.name ?? "Unknown")
    }
}

struct ServicesForStationView_Previews: PreviewProvider {
    static var previews: some View {
        
        let services = [
            Service(id: "id", platform: "1b", station: "Birmingham New Street", status: .onTime, scheduledTime: "14:44", expMins: 10),
            Service(id: "id", platform: "12b", station: "Manchester", status: .late, scheduledTime: "15:00", expMins: 20),
            Service(id: "id", platform: "10a", station: "Southamption", status: .cancelled, scheduledTime: "16:22", expMins: 60),
            Service(id: "id", platform: nil, station: "Cardiff", status: .onTime, scheduledTime: "16:25", expMins: 63)
        ]
        
        let emptyServices = [Service]()
        
        let stationRequest = StationRequest(station: Station(id: "EUS", name: "London Euston"), filterStation: nil, type: .departure)
        
        return Group{
            ServicesForStationView(stationReq: stationRequest, services: services)
            ServicesForStationView(stationReq: stationRequest, services: services)
                .preferredColorScheme(.dark)
            ServicesForStationView(stationReq: stationRequest, services: emptyServices)
        }
    }
}
