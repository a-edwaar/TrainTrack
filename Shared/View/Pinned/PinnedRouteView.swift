//
//  PinnedRouteView.swift
//  TrainTrack
//
//  Created by Archie Edwards on 18/07/2020.
//

import SwiftUI

struct PinnedRouteView: View {
    var pinned = PinnedRequest(name: "Uni", request: StationRequest(station: Station(id: "BHM", name: "Birmingham New Street"), filterStation: Station(id: "MAN", name: "Manchester"), type: .arrival))
    var body: some View{
        VStack{
            PinnedLabelView(pinName: pinned.name)
            NavigationLink(
                destination: StationView(stationReq: pinned.request),
                label: {
                    PinnedRouteContentView{
                        if pinned.request.type == .departure{
                            Text("\(pinned.request.station?.id ?? "?") ")
                                .font(.title)
                                .bold()
                            Label(pinned.request.filterStation?.id ?? "ANY", systemImage: "arrow.right")
                                .font(.title)
                                .foregroundColor(.secondary)
                        }else{
                            HStack(spacing: 0){
                                Text("\(pinned.request.filterStation?.id ?? "ANY") ")
                                Image(systemName: "arrow.right")
                            }
                            .font(.title)
                            .foregroundColor(.secondary)
                            Text(" \(pinned.request.station?.id ?? "?") ")
                                .font(.title)
                                .bold()
                        }
                       
                    }
                }).buttonStyle(PlainButtonStyle())
        }
    }
}

struct PinnedRouteView_Previews: PreviewProvider {
    static var previews: some View {
        PinnedRouteView().padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}
