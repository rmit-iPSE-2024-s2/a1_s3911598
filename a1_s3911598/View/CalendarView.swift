//
//  CalendarView.swift
//  a1_s3911598
//
//  Created by Lea Wang on 27/8/2024.
//



import SwiftUI

struct CalendarView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var currentDate = Date()
    @State private var emotionLogs: [EmotionLog] = [
        // Example data
        EmotionLog(time: "15:25", emotion: "Happy"),
        EmotionLog(time: "16:05", emotion: "Sad")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                // Month and Year Display
                HStack {
                    Button(action: previousMonth) {
                        Image(systemName: "chevron.left")
                    }
                    Spacer()
                    Text(currentDate, formatter: dateFormatterForMonthYear()).font(.title)
                    Spacer()
                    Button(action: nextMonth) {
                        Image(systemName: "chevron.right")
                    }
                }
                .padding()
                
                // Calendar Grid
                let days = generateDaysInMonth(for: currentDate)
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                    ForEach(days, id: \.self) { day in
                        Text(dayString(day))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(isSameDay(date1: day, date2: currentDate) ? Color.blue : Color.clear)
                            .clipShape(Circle())
                            .onTapGesture {
                                selectDate(day)
                            }
                    }
                }
                
                // Emotion Logs
                VStack(alignment: .leading) {
                    Text("Today")
                        .font(.headline)
                        .padding(.top)
                    
                    Text(currentDate, formatter: dateFormatterForDay()).font(.subheadline)
                    
                    ForEach(emotionLogs, id: \.time) { log in
                        HStack {
                            Text("\(log.time),")
                            Text("you noticed your emotion (\(log.emotion))")
                        }
                        .padding(.vertical, 5)
                    }
                }
                .padding()
                
                Spacer()
                
                // Back Button
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Back")
                        .foregroundColor(.blue)
                }
                .padding()
            }
            .navigationBarTitle("Calendar", displayMode: .inline)
        }
    }
    
    // MARK: - Functions

    func previousMonth() {
        currentDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
    }
    
    func nextMonth() {
        currentDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
    }
    
    func selectDate(_ day: Date) {
        currentDate = day
        // Load corresponding emotion logs if any
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        Calendar.current.isDate(date1, inSameDayAs: date2)
    }
    
    func generateDaysInMonth(for date: Date) -> [Date] {
        var days: [Date] = []
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: date)!
        
        for day in range {
            if let dayDate = calendar.date(bySetting: .day, value: day, of: date) {
                days.append(dayDate)
            }
        }
        
        return days
    }
    
    func dayString(_ date: Date) -> String {
        let day = Calendar.current.component(.day, from: date)
        return "\(day)"
    }
}



func dateFormatterForMonthYear() -> DateFormatter {
    configureDateFormatter(withFormat: "MMMM yyyy")
    return dateFormatter
}

func dateFormatterForDay() -> DateFormatter {
    configureDateFormatter(withFormat: "MMM d, yyyy")
    return dateFormatter
}

struct EmotionLog {
    var time: String
    var emotion: String
}

