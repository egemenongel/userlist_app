//
//  UserDetailRepository.swift
//  exampleproject
//
//  Created by Egemen Öngel on 18.01.2025.
//

import Foundation

protocol UserDetailRepositoryProtocol {
    func fetchUserDetails(userId: Int, completion: @escaping (Result<User, Error>) -> Void)
}

class UserDetailRepository: UserDetailRepositoryProtocol {
    private let networkManager: NetworkProtocol

    init(networkManager: NetworkProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }

    func fetchUserDetails(userId: Int, completion: @escaping (Result<User, Error>) -> Void) {
        networkManager.request(endpoint: "/users/\(userId)") { result in
            switch result {
            case .success(let data):
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(.success(user))
                } catch {
                    completion(.failure(NetworkError.decodingError))
                }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}
