//
//  UserDetailService.swift
//  exampleproject
//
//  Created by Egemen Öngel on 18.01.2025.
//

import Foundation

protocol UserDetailServiceProtocol {
    func fetchUserDetails(userId: Int, completion: @escaping (Result<User, Error>) -> Void)
}

class UserDetailService: UserDetailServiceProtocol {
    private let repository: UserDetailRepositoryProtocol

    init(repository: UserDetailRepositoryProtocol = UserDetailRepository()) {
        self.repository = repository
    }

    func fetchUserDetails(userId: Int, completion: @escaping (Result<User, Error>) -> Void) {
        repository.fetchUserDetails(userId: userId, completion: completion)
    }
}

class MockUserDetailRepository: UserDetailRepositoryProtocol {
    var shouldReturnError = false

    func fetchUserDetails(userId: Int, completion: @escaping (Result<User, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch user details"])))
        } else {
            let mockUser = User(id: userId, name: "John Doe", email: "johndoe@example.com", phone: "123-456-7890", website: "johndoe.com")
            completion(.success(mockUser))
        }
    }
}
