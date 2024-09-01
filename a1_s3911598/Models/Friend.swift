//
//  Friend.swift
//  a1_s3911598
//
//  Created by Lea Wang on 27/8/2024.
//

import Foundation

struct Friend: Identifiable {
    var id = UUID()
    var name: String
    var profilePicture: String
    var lastMood: String
}

// sample data gonna change it later
extension Friend {
    static let sampleData: [Friend] = [
        Friend(name: "Alice", profilePicture: "Profile1", lastMood: "Happy"),
        Friend(name: "Bob", profilePicture: "Profile2", lastMood: "Sad"),
        Friend(name: "Charlie", profilePicture: "Profile3", lastMood: "Excited")
    ]
}

