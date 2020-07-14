//
//  ServiceCancelledView.swift
//  TrainTrack
//
//  Created by Archie Edwards on 05/07/2020.
//

import SwiftUI

struct ServiceCancelledView: View {
    var body: some View {
        Text("Cancelled")
            .font(.headline)
            .foregroundColor(.red)
    }
}

struct ServiceCancelledView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceCancelledView()
    }
}
