//
//  ServiceComponenetView.swift
//  TrainTrack
//
//  Created by Archie Edwards on 02/07/2020.
//

import SwiftUI

struct ServiceComponenetView: View {
    
    var service : Service
    var type : Type
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(service.destination ?? "Unknown")
                    .bold()
                Text(service.expMinsForStatus(type: type))
                    .foregroundColor(.secondary)
                    .bold()
                ProgressView(value: service.expMinsForProgressBar(type: type) , total: 1)
                    .progressViewStyle(LinearProgressViewStyle(tint: service.status?.color ?? .green))
            }
            Spacer()
            if service.platform != nil{
                Text("Plat")
                    .font(.footnote)
                Text(service.platform!)
                    .font(.footnote)
                    .bold()
            }
        }
    }
}

struct ServiceComponenetView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceComponenetView(service: Service(id: "1", platform: "1b", operatorName: "Virgin", origin: "London", destination: "Birmingham", status: .late, aimedDepartureTime: "16:40", aimedArrivalTime: "16:39", expDepartureTime: "16:42", expArrivalTime: "16:40", expDepartureMins: 4, expArrivalMins: 2), type: .departure)
    }
}
