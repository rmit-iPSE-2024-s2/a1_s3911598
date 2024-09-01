//
//  CalendarView.swift
//  a1_s3911598
//
//  Created by Lea Wang on 27/8/2024.
//


import SwiftUI

struct MoodView: View {
    @State private var showCalendar = false
    @State private var showMoodTracking = false
    @State private var isActive = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // My daily mood record section
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text("My daily mood record")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        showCalendar = true
                    }) {
                        HStack {
                            Image(systemName: "eyes")
                            Text("View all")
                        }
                    }
                    .sheet(isPresented: $showCalendar) {
                        CalendarView()
                    }
                }
                .padding(.horizontal)
                
                
                Spacer().frame(height: 20)

                // Mood tracking card
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("CardBackground"))
                        .frame(height: 120)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Recent")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("08-30")
                                .font(.caption)
                            Text("Very unpleasant")
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        Spacer()
                        VStack {
                            Text("Mood tracking")
                                .font(.headline)
                            Spacer()
                            Button(action: {
                                showMoodTracking = true
                            }) {
                                HStack {
                                    Text("Go record")
                                    Image(systemName: "pencil")
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                            .sheet(isPresented: $showMoodTracking) {
                                MoodTrackingView(isActive: $showMoodTracking)
                            }
                        }
                    }
                    .padding()
                }
                .padding(.horizontal)

                // Recent mood distribution section
                VStack(alignment: .leading) {
                    HStack {
                        Text("🌼 Recent mood distribution")
                            .font(.headline)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color("CardBackground"))
                            .frame(height: 200)
                        
                        // Mood distribution content (Remove the upgrade button)
                        VStack {
                            // Custom distribution graph (replace with your data)
                            Text("Currently displaying sample data")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding()
                    }
                    .padding(.horizontal)
                }
                
                // More content can go here
                Spacer()
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Me")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
        .background(Color("AppBackground").edgesIgnoringSafeArea(.all))
    }
}


struct MoodTrackingView: View {
    @Binding var isActive: Bool
    @State private var moodValue: Double = 0.5
    @State private var showingMoodDetailView = false
    @State private var selectedMoodLabel = "Neutral"
    
    let moodColors = [
        Color(red: 0.68, green: 0.77, blue: 0.89),
        Color(red: 0.74, green: 0.83, blue: 0.91),
        Color(red: 0.79, green: 0.88, blue: 0.94),
        Color(red: 0.93, green: 0.88, blue: 0.68),
        Color(red: 0.98, green: 0.86, blue: 0.53),
        Color(red: 0.99, green: 0.80, blue: 0.67),
        Color(red: 0.99, green: 0.70, blue: 0.63)
    ]
    
    let moodLabels = [
        "Very unpleasant",
        "Unpleasant",
        "Slightly unpleasant",
        "Neutral",
        "Slightly pleasant",
        "Pleasant",
        "Very pleasant"
    ]
    
    var body: some View {
        ZStack {
            moodColors[Int(moodValue * Double(moodColors.count - 1))]
                .edgesIgnoringSafeArea(.all)
                .animation(.easeInOut, value: moodValue)
            
            VStack(spacing: 20) {
                Spacer()
                
                //will add a image here
                Image("ImageName") // Use the actual image name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                
                ZStack {
                    Slider(value: $moodValue)
                        .padding(.horizontal)
                    
                    // Display mood label in a speech bubble style
                    Text(moodLabels[Int(moodValue * Double(moodLabels.count - 1))])
                        .font(.headline)
                        .padding(.all, 8)
                        .background(Color.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .offset(x: (CGFloat(moodValue) - 0.5) * 300, y: -50) // Adjust the position of the speech bubble
                        .animation(.easeInOut, value: moodValue)
                }
                
                HStack {
                    Text("Very unpleasant")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("Very pleasant")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    self.selectedMoodLabel = moodLabels[Int(moodValue * Double(moodLabels.count - 1))]
                    self.showingMoodDetailView = true
                }) {
                    HStack {
                        Spacer() // Ensure the button can be clicked anywhere within its frame
                        Text("Next")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 50)
        }
        .sheet(isPresented: $showingMoodDetailView) {
            MoodDetailView(isActive: $isActive, selectedMood: $selectedMoodLabel)
        }
    }
}


struct MoodDetailView: View {
    @State private var moodText: String = ""
    @Environment(\.dismiss) var dismiss
    @Binding var isActive: Bool
    @Binding var selectedMood: String
    let currentDate = Date()

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .center) {
            // Show current date
            Text(currentDate, formatter: dateFormatter)
                .font(.headline)
                .padding(.top, 20)

            // Show the user's selected mood image
            Image(imageName(for: selectedMood))
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.top, 20)

            // Show the selected mood
            Text("“ \(selectedMood) ”")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.vertical, 10)

            // Display different text based on the selected mood
            Text(displayText(for: selectedMood))
                .font(.body)
                .padding(.bottom, 10)
                .padding(.horizontal)
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)

            // Mood input TextField
            TextField("Write down your mood", text: $moodText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)

            Spacer()

            // Done button
            Button(action: {
                self.isActive = false  // This will close the MoodTrackingView
            }) {
                HStack {
                    Spacer()
                    Text("Done")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            }
            .padding(.bottom, 20)
        }
        .padding(.horizontal)
        .background(Color(UIColor.systemGray5).edgesIgnoringSafeArea(.all))  // Set background color
    }

    // Return the corresponding image name based on the selected mood
    func imageName(for mood: String) -> String {
        switch mood {
        case "Slightly pleasant":
            return "slightlyUnpleasant"
        case "Pleasant":
            return "happy"
        case "Very pleasant":
            return "very happy"
        case "Very unpleasant":
            return "VeryUnpleasant"
        case "Unpleasant":
            return "unpleasant"
        default:
            return "normal"  // Default image
        }
    }

    // Update the text above based on the user's selected mood
    func displayText(for mood: String) -> String {
        switch mood {
        case "Slightly pleasant":
            return "Keep calm and carry on."
        case "Pleasant", "Very pleasant":
            return "Good to know you're feeling great."
        case "Very unpleasant":
            return "I sometimes feel very bad too, I understand how oppressively heavy that can feel."
        case "Slightly unpleasant":
            return "I have been just ok at times as well."
        default:
            return "Good to know you're feeling \(mood.lowercased())!"
        }
    }
}

struct MoodView_Previews: PreviewProvider {
    static var previews: some View {
        MoodView()
    }
}

