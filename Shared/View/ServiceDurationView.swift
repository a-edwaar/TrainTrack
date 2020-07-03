//
//  ServiceDurationView.swift
//  TrainTrack
//
//  Created by Archie Edwards on 05/07/2020.
//

import SwiftUI

struct ServiceDurationView: View {
    var service : Service
    var type : Type
    var body: some View {
        VStack(alignment: .leading){
            Text(service.expMinsForStatus(type: type))
                .font(.largeTitle)
                .foregroundColor(.secondary)
                .bold()
            ProgressView(value: service.expMinsForProgressBar(type: type) , total: 1)
                .progressViewStyle(LinearProgressViewStyle(tint: service.status?.color ?? .green))
        }
    }
}

struct ServiceDurationView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceDurationView(service: Service(id: "1", platform: "1b", operatorName: "Virgin", origin: "London", destination: "Birmingham", status: .late, aimedDepartureTime: "16:40", aimedArrivalTime: "16:39", expDepartureTime: "16:42", expArrivalTime: "16:40", expDepartureMins: 4, expArrivalMins: 2), type: .departure)
    }
}
