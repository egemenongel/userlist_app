//
//  UserRepository.swift
//  exampleproject
//
//  Created by Egemen Öngel on 18.01.2025.
//

import Foundation

protocol UserRepositoryProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
}

class UserRepository: UserRepositoryProtocol {
    private let networkManager: NetworkProtocol

    init(networkManager: NetworkProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }

    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        networkManager.request(endpoint: "/users") { result in
            switch result {
            case .success(let data):
                do {
                    let users = try JSONDecoder().decode([User].self, from: data)
                    completion(.success(users))
                } catch {
                    completion(.failure(NetworkError.decodingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
