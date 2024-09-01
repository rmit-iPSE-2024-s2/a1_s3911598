//
//  RecentMoodDistributionView.swift
//  a1_s3911598
//
//  Created by Lea Wang on 28/8/2024.
//

import SwiftUI



//hardcode for now will do API in assignment2
struct RecentMoodDistributionView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("🌼 Recent mood distribution")
                .font(.headline)
                .padding(.bottom, 5)
            
            HStack(alignment: .bottom, spacing: 15) {
                VStack {
                    Image(systemName: "face.smiling")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Sad").font(.caption)
                    Rectangle().fill(Color.blue)
                        .frame(width: 20, height: 50) // Example height
                }
                
                VStack {
                    Image(systemName: "face.smiling")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Neutral").font(.caption)
                    Rectangle().fill(Color.yellow)
                        .frame(width: 20, height: 75) // Example height
                }
                
                VStack {
                    Image(systemName: "face.smiling")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Happy").font(.caption)
                    Rectangle().fill(Color.orange)
                        .frame(width: 20, height: 100) // Example height
                }
                
                VStack {
                    Image(systemName: "face.smiling")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Excited").font(.caption)
                    Rectangle().fill(Color.red)
                        .frame(width: 20, height: 125) // Example height
                }
            }
            .padding(.bottom, 20)
            

        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

