//
//  User.swift
//  exampleproject
//
//  Created by Egemen Öngel on 18.01.2025.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let website: String
}
