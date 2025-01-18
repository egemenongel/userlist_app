//
//  UserDetailService.swift
//  exampleproject
//
//  Created by Egemen Öngel on 18.01.2025.
//

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
