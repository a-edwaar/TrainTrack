//
//  NetworkManager.swift
//  TrainTrack
//
//  Created by Archie Edwards on 28/06/2020.
//

import Foundation

public final class NetworkManager {
    private let p: NetworkManagerProtocol

    init(p: NetworkManagerProtocol = URLSession.shared) {
        self.p = p
    }

    func executeRequest(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        p.executeRequest(request: request){ (data, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            completion(.success(data))
        }
    }
}
