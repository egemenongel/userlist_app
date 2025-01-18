//
//  UserListViewModel.swift
//  exampleproject
//
//  Created by Egemen Öngel on 18.01.2025.
//

import Foundation

class UserListViewModel {
    private var users: [User] = []
    private var service: UserServiceProtocol
    
    var reloadData: (() -> Void)?
    
    init(service: UserServiceProtocol) {
        self.service = service
    }
    
    func fetchUsers() {
        service.fetchUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                self?.reloadData?()
            case .failure(let error):
                print("Error fetching users: \(error)")
            }
        }
    }
    
    var numberOfUsers: Int {
        return users.count
    }
    
    func user(at index: Int) -> User {
        return users[index]
    }
}
