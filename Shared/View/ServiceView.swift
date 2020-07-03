//
//  ServiceView.swift
//  TrainTrack
//
//  Created by Archie Edwards on 02/07/2020.
//

import SwiftUI

struct ServiceView: View {
    
    var service : Service
    var type : Type
    
    var body: some View {
        VStack(alignment: .leading){
            ServiceDestinationView(destination: service.destination, platform: service.platform)
            if service.status == .cancelled {
                ServiceCancelledView()
            }else{
                ServiceDurationView(service: service, type: type)
            }
        }
    }
}

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ServiceView(service: Service(id: "1", platform: "1b", operatorName: "Virgin", origin: "London", destination: "Birmingham", status: .late, aimedDepartureTime: "16:40", aimedArrivalTime: "16:39", expDepartureTime: "16:42", expArrivalTime: "16:40", expDepartureMins: 4, expArrivalMins: 2), type: .departure)
            ServiceView(service: Service(id: "1", platform: "1b", operatorName: "Virgin", origin: "London", destination: "Birmingham New Street", status: .cancelled, aimedDepartureTime: "16:40", aimedArrivalTime: "16:39", expDepartureTime: "16:42", expArrivalTime: "16:40", expDepartureMins: 4, expArrivalMins: 2), type: .departure)
        }
    }
}
