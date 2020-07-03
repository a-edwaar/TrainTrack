//
//  NetworkError.swift
//  TrainTrack
//
//  Created by Archie Edwards on 30/06/2020.
//

import Foundation

enum NetworkError: Error {
    case noData
}

extension NetworkError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noData:
            return NSLocalizedString("No data returned from request", comment: "No data")
        }
    }
}
