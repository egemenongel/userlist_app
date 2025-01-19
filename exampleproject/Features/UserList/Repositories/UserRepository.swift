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

class MockUserRepository: UserRepositoryProtocol {
    var shouldReturnError = false

    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch users"])))
        } else {
            let mockUsers = [
                User(id: 1, name: "John Doe", email: "johndoe@example.com", phone: "123-456-7890", website: "johndoe.com"),
                User(id: 2, name: "Jane Smith", email: "janesmith@example.com", phone: "987-654-3210", website: "janesmith.com")
            ]
            completion(.success(mockUsers))
        }
    }
}
