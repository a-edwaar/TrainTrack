//
//  JSONDecoderProtocol.swift
//  TrainTrack
//
//  Created by Archie Edwards on 30/06/2020.
//

import Foundation

protocol JSONDecoderProtocol {
    func decode(_ type: Station.Type, from data: Data) throws -> Station
}

extension JSONDecoder : JSONDecoderProtocol{
}
