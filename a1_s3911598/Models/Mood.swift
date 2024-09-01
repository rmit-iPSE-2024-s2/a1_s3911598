//
//  Mood.swift
//  a1_s3911598
//
//  Created by Lea Wang on 27/8/2024.
//

import Foundation

struct Mood: Identifiable {
    var id = UUID()
    var description: String
    var value: Double  // 情绪值可以是一个简单的浮点数表示强度
    var time: Date
}

enum MoodType: String, CaseIterable, Identifiable {
    case happy = "Happy"
    case sad = "Sad"
    case excited = "Excited"
    case neutral = "Neutral"

    var id: String { self.rawValue }
}

// 示例数据
extension Mood {
    static let sampleData: [Mood] = [
        Mood(description: "Happy", value: 8.0, time: Date()),
        Mood(description: "Sad", value: 2.0, time: Date()),
        Mood(description: "Excited", value: 9.5, time: Date())
    ]
}

