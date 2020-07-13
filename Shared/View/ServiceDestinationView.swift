//
//  ServiceDestinationView.swift
//  TrainTrack
//
//  Created by Archie Edwards on 05/07/2020.
//

import SwiftUI

struct ServiceDestinationView: View {
    var scheduledTime: String
    var destination: String
    var platform: String?
    var body: some View {
        HStack{
            Text(scheduledTime)
                .font(.headline)
            Text(destination)
                .font(.headline)
            Spacer()
            if platform != nil{
                Text("Plat")
                    .font(.footnote)
                Text(platform!)
                    .font(.footnote)
                    .bold()
            }
        }
    }
}

struct ServiceDestinationView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceDestinationView(scheduledTime: "14:44",destination: "Birmingham", platform: "1b")
    }
}
