//
//  Status+SwiftUI.swift
//  TrainTrack
//
//  Created by Archie Edwards on 02/07/2020.
//

import SwiftUI

extension Status {
    var color : Color {
        switch self {
        case .cancelled, .late:
            return Color.red
        case .other:
            return Color.orange
        default:
            return Color.green
        }
    }
}
