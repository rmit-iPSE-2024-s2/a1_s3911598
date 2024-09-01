//
//  User.swift
//  a1_s3911598
//
//  Created by Lea Wang on 27/8/2024.
//

import Foundation

struct User {
    var email: String
    var password: String  
}

// example data
extension User {
    static let sampleData = User(email: "lea@example.com", password: "123")
}

