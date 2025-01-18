//
//  NetworkManager.swift
//  exampleproject
//
//  Created by Egemen Öngel on 18.01.2025.
//

import Foundation

protocol NetworkProtocol {
    func request(endpoint: String, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkManager: NetworkProtocol {
    private let baseURL = "https://jsonplaceholder.typicode.com"

    func request(endpoint: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            completion(.success(data))
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
