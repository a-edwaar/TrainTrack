//
//  ContentView.swift
//  Shared
//
//  Created by Archie Edwards on 27/06/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        StationView(stationID: "BHM", stationName: "Birmingham New Street")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
