//
//  NetworkManagerProtocol.swift
//  TrainTrack
//
//  Created by Archie Edwards on 30/06/2020.
//

import Foundation

protocol NetworkManagerProtocol {
    func executeRequest(request: URLRequest, completion: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkManagerProtocol{
    func executeRequest(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: request) { (data, _, error) in
            completion(data, error)
        }
        task.resume()
    }
}
