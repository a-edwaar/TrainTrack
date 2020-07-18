//
//  ServiceView.swift
//  TrainTrack
//
//  Created by Archie Edwards on 02/07/2020.
//

import SwiftUI

struct ServiceView: View {
    
    var service : Service
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0){
                ServiceDestinationView(scheduledTime: service.scheduledTime, destination: service.station, platform: service.platform)
                if service.status == .cancelled {
                    ServiceCancelledView()
                }else{
                    ServiceDurationView(service: service)
                }
            }.padding(.all, 10)
        }.background(Color("Background")).cornerRadius(10)
    }
}

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView(service: Service(id: "id", platform: "1b", station: "Birmingham New Street", status: .onTime, scheduledTime: "14:44", expMins: 10))
    }
}
