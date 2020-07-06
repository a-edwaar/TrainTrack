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
        GeometryReader{ proxy in
            VStack(alignment: .leading, spacing: 10){
                Text(service.expMinsForStatus(type: type))
                    .font(.headline)
                    .foregroundColor(.secondary)
                ZStack(alignment: .leading){
                    Rectangle()
                        .foregroundColor(.gray)
                        .opacity(0.5)
                        .frame(width: proxy.size.width, height: 5)
                    Rectangle()
                        .foregroundColor(service.status?.color)
                        .frame(width: proxy.size.width * CGFloat(service.expMinsForProgressBar(type: type)), height: 5)
                }
            }
        }.frame(height: 40)
    }
}

struct ServiceDurationView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceDurationView(service: Service(id: "1", platform: "1b", operatorName: "Virgin", origin: "London", destination: "Birmingham", status: .late, aimedDepartureTime: "16:40", aimedArrivalTime: "16:39", expDepartureTime: "16:42", expArrivalTime: "16:40", expDepartureMins: 4, expArrivalMins: 2), type: .departure)
    }
}
