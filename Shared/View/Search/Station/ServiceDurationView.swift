//
//  ServiceDurationView.swift
//  TrainTrack
//
//  Created by Archie Edwards on 05/07/2020.
//

import SwiftUI

struct ServiceDurationView: View {
    var service : Service
    var body: some View {
        GeometryReader{ proxy in
            VStack(alignment: .leading, spacing: 10){
                Text(service.expMinsForStatus())
                    .font(.headline)
                    .foregroundColor(.secondary)
                ZStack(alignment: .leading){
                    Rectangle()
                        .foregroundColor(.gray)
                        .opacity(0.5)
                        .frame(width: proxy.size.width, height: 5)
                    Rectangle()
                        .foregroundColor(service.status.color)
                        .frame(width: proxy.size.width * CGFloat(service.expMinsForProgressBar()), height: 5)
                }
            }
        }.frame(height: 40)
    }
}

struct ServiceDurationView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceDurationView(service: Service(id: "id", platform: "1b", station: "Birmingham New Street", status: .onTime, scheduledTime: "14:44", expMins: 10))
    }
}
