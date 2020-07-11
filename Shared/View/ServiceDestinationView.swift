//
//  ServiceDestinationView.swift
//  TrainTrack
//
//  Created by Archie Edwards on 05/07/2020.
//

import SwiftUI

struct ServiceDestinationView: View {
    var destination: String?
    var platform: String?
    var body: some View {
        HStack{
            Text(destination ?? "Unknown")
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
        ServiceDestinationView(destination: "Birmingham", platform: "1b")
    }
}
