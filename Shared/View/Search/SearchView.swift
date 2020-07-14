//
//  SearchView.swift
//  TrainTrack
//
//  Created by Archie Edwards on 15/07/2020.
//

import SwiftUI

struct ShowPicker : Identifiable {
    var id : StationPicked
    
    init(_ id: StationPicked) {
        self.id = id
    }
    
    enum StationPicked {
        case primary
        case secondary
    }
}

struct SearchView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var stationReq = StationRequest(station: nil, filterStation: nil, type: .departure)
    @State var showPickerModal : ShowPicker?
    var stationsModel = StationsViewModel()
    
    var body: some View {
        NavigationView{
            VStack() {
                HStack {
                    Spacer()
                    Picker(selection: $stationReq.type, label: Text("Picker")){
                        Text("Departures").tag(Type.departure)
                        Text("Arrivals").tag(Type.arrival)
                    }.pickerStyle(SegmentedPickerStyle())
                    Button(action: {
                        stationReq.station = nil
                        stationReq.filterStation = nil
                    }, label: {
                        Text("Clear")
                            .foregroundColor(stationReq.station == nil && stationReq.filterStation == nil ? .secondary : .primary)
                    }).buttonStyle(PlainButtonStyle())
                    Spacer()
                }
                Form{
                    Section(header: Text(stationReq.type == .departure ? "Departing from" : "Arriving at")){
                        Button(action: {
                            self.showPickerModal = ShowPicker(.primary)
                        }, label: {
                            Text(stationReq.station?.name ?? "Choose station")
                        })
                    }
                    Section(header: Text(stationReq.type == .departure ? "Calling at" : "From")){
                        Button(action: {
                            self.showPickerModal = ShowPicker(.secondary)
                        }, label: {
                            Text(stationReq.filterStation?.name ?? "Choose station")
                        })
                    }
                    NavigationLink(
                        destination: StationView(stationReq: stationReq),
                        label: {
                            Text("Search")
                        }).disabled(stationReq.station == nil)
                }
            }
            .padding(.top, 10)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }.fullScreenCover(item: $showPickerModal){ showPicker in
            StationPickerView(stations: stationsModel.stations, stationPicked: showPicker.id == .primary ? self.$stationReq.station : self.$stationReq.filterStation, showModal: self.$showPickerModal).environment(\.colorScheme, colorScheme)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchView()
            SearchView()
                .preferredColorScheme(.dark)
        }
    }
}
