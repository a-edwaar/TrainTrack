//
//  StationPickerView.swift
//  TrainTrack
//
//  Created by Archie Edwards on 14/07/2020.
//

import SwiftUI

struct StationPickerView: View {
    
    var stations : [String:[Station]]
    @Binding var stationPicked : Station?
    @Binding var showModal : ShowPicker?
    @Environment(\.colorScheme) var colorScheme
    @State private var searchText : String = ""
    
    var body: some View {
        VStack{
            HStack{
                SearchBar(text: $searchText, placeholder: "Search station")
                Button(action: {
                    self.showModal = nil
                }, label: {
                    Text("Cancel")
                })
            }.padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            List{
                ForEach(stations.keys.sorted(), id: \.self){ section in
                    if searchText.isEmpty {
                        Section(header: Text(section)){
                            ForEach(stations[section]!) { station in
                                stationButton(station)
                            }
                        }
                    }else{
                        ForEach(stations[section]!.filter {
                            $0.name.lowercased().contains(self.searchText.lowercased()) || $0.id.lowercased().contains(self.searchText.lowercased())
                        }) { station in
                            stationButton(station)
                        }
                    }
                }
            }
        }
    }
    
    func stationButton(_ station: Station) -> some View{
        return Button(action: {
            self.stationPicked = station
            self.showModal = nil
        }, label: {
            Text("\(station.name) (\(station.id))")
        })
    }
}

struct StationPickerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StationPickerView(stations: StationsViewModel().stations,stationPicked: .constant(nil), showModal: .constant(ShowPicker(.primary)))
            StationPickerView(stations: StationsViewModel().stations,stationPicked: .constant(nil), showModal: .constant(ShowPicker(.primary)))
                .preferredColorScheme(.dark)
        }
    }
}
