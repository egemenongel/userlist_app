//
//  UserService.swift
//  exampleproject
//
//  Created by Egemen Öngel on 18.01.2025.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
}

class UserService: UserServiceProtocol {
    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }

    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        repository.fetchUsers(completion: completion)
    }
}

class MockUserService: UserServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        let mockUsers = [
            User(id: 1, name: "John Doe", email: "johndoe@example.com", phone: "123-456-7890", website: "johndoe.com"),
            User(id: 2, name: "Jane Smith", email: "janesmith@example.com", phone: "987-654-3210", website: "janesmith.com")
        ]
        completion(.success(mockUsers))
    }
}
