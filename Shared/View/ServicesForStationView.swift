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
        NavigationView{
            List {
                ForEach(services) { service in
                    NavigationLink(
                        destination: Text("hello"),
                        label: {
                            ServiceComponenetView(service: service, type: type)
                        }
                    )
                }
            }.navigationBarTitle(station)
        }
    }
}

struct ServicesForStationView_Previews: PreviewProvider {
    static var previews: some View {
        ServicesForStationView(station: "BHM",type: .departure, services: [Service(id: "1", platform: "1b", operatorName: "Virgin", origin: "London", destination: "Birmingham", status: .late, aimedDepartureTime: "16:40", aimedArrivalTime: "16:39", expDepartureTime: "16:42", expArrivalTime: "16:40", expDepartureMins: 4, expArrivalMins: 2)])
    }
}
