//
//  PinnedLabelView.swift
//  TrainTrack
//
//  Created by Archie Edwards on 18/07/2020.
//

import SwiftUI

struct PinnedLabelView: View {
    var pinName: String
    var body: some View {
        HStack{
            Label(pinName, systemImage: "pin")
                .font(.headline)
                .foregroundColor(.yellow)
            Spacer()
        }
    }
}

struct PinnedLabelView_Previews: PreviewProvider {
    static var previews: some View {
        PinnedLabelView(pinName: "Uni")
    }
}
