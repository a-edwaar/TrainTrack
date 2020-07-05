//
//  ServicesForStationView.swift
//  TrainTrack
//
//  Created by Archie Edwards on 29/06/2020.
//

import SwiftUI

struct ServicesForStationView: View {
    
    var station : String
    var type: Type
    var services : [Service]
    
    var body: some View{
        VStack{
            Text(station)
                .bold()
            List {
                ForEach(services) { service in
                    ServiceView(service: service, type: type)
                }
            }
        }
    }
}

struct ServicesForStationView_Previews: PreviewProvider {
    static var previews: some View {
        
        let services : [Service] = [
            Service(id: "1", platform: "1b", operatorName: "Virgin", origin: "London", destination: "Edinburgh", status: .late, aimedDepartureTime: "16:40", aimedArrivalTime: "16:39", expDepartureTime: "16:42", expArrivalTime: "16:40", expDepartureMins: 4, expArrivalMins: 2),
            Service(id: "2", platform: "2a", operatorName: "West Midlands", origin: "Southampton", destination: "Birmingham New Street", status: .onTime, aimedDepartureTime: "16:55", aimedArrivalTime: "16:54", expDepartureTime: "16:55", expArrivalTime: "16:54", expDepartureMins: 10, expArrivalMins: 9),
            Service(id: "3", platform: "5b", operatorName: "Great Western", origin: "Cardiff", destination: "Manchester", status: .cancelled, aimedDepartureTime: "17:20", aimedArrivalTime: "17:20", expDepartureTime: "17:20", expArrivalTime: "17:20", expDepartureMins: 30, expArrivalMins: 30),
            Service(id: "4", platform: "2a", operatorName: "West Midlands", origin: "Southampton", destination: "Birmingham", status: .onTime, aimedDepartureTime: "17:40", aimedArrivalTime: "17:40", expDepartureTime: "17:40", expArrivalTime: "17:40", expDepartureMins: 50, expArrivalMins: 50)
        ]
        
        return ServicesForStationView(station: "Birmingham New Street",type: .departure, services: services)
            .preferredColorScheme(.light)
    }
}
