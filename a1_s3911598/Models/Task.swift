//
//  Task.swift
//  a1_s3911598
//
//  Created by Lea Wang on 27/8/2024.
//

import Foundation

struct Task: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var time: Date
    var sharedWith: [String] 
}

// example data
extension Task {
    static let sampleData: [Task] = [
        Task(title: "Complete assignment", description: "Finish the SwiftUI assignment for the course", time: Date(), sharedWith: ["Alice", "Bob"]),
        Task(title: "Grocery shopping", description: "Buy vegetables and fruits for the week", time: Date(), sharedWith: ["Charlie"]),
        Task(title: "Call Mom", description: "Weekly catch-up call with mom", time: Date(), sharedWith: [])
    ]
}


