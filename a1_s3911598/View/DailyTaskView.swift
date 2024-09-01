//
//  DailyTaskView.swift
//  a1_s3911598
//
//  Created by Lea Wang on 27/8/2024.
//

import SwiftUI

struct DailyTaskView: View {
    @State private var tasks = Task.sampleData
    @State private var showingCreateTaskView = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Daily Tasks")
                    .font(.custom("Chalkboard SE", size: 24))
                    .padding([.leading, .top], 16)
                
                Spacer()
                
                Button(action: {
                    showingCreateTaskView = true
                }) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .padding(.trailing, 16)
                }
            }

            List {
                Section(header: Text("Shared Tasks").font(.custom("Chalkboard SE", size: 20)).padding(.top, -10)) {
                    ForEach(tasks.filter { !$0.sharedWith.isEmpty }) { task in
                        TaskCard(task: task)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                                        tasks.remove(at: index)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                .tint(.gray)
                            }
                    }
                    .onDelete(perform: deleteTask)
                }

                Section(header: Text("My Daily Tasks").font(.custom("Chalkboard SE", size: 20)).padding(.top, -10)) {
                    // Add your personal tasks here
                    // Example:
                    ForEach(tasks.filter { $0.sharedWith.isEmpty }) { task in
                        TaskCard(task: task)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                                        tasks.remove(at: index)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                .tint(.gray)
                            }
                    }
                    .onDelete(perform: deleteTask)
                }
            }
            .listStyle(PlainListStyle())
            .sheet(isPresented: $showingCreateTaskView) {
                CreateTaskView(isPresented: $showingCreateTaskView, tasks: $tasks)
            }
        }
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}


struct CreateTaskView: View {
    @Binding var isPresented: Bool
    @Binding var tasks: [Task]
    @State private var title = ""
    @State private var description = ""
    @State private var time = Date()

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Create a New Task")
                    .font(.custom("Chalkboard SE", size: 24))
                    .padding([.top, .leading], 16)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Task Title")
                        .font(.custom("Chalkboard SE", size: 18))
                        .padding(.leading, 10)

                    TextField("Enter title", text: $title)
                        .font(.custom("Chalkboard SE", size: 18))
                        .padding()
                        .background(Color(white: 0.9))
                        .cornerRadius(10)
                        .padding(.horizontal)

                    Text("Task Description")
                        .font(.custom("Chalkboard SE", size: 18))
                        .padding(.leading, 10)

                    TextField("Enter description", text: $description)
                        .font(.custom("Chalkboard SE", size: 18))
                        .padding()
                        .background(Color(white: 0.9))
                        .cornerRadius(10)
                        .padding(.horizontal)

                    Text("Time")
                        .font(.custom("Chalkboard SE", size: 18))
                        .padding(.leading, 10)

                    DatePicker("Select Time", selection: $time, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .font(.custom("Chalkboard SE", size: 18))
                        .padding()
                        .background(Color(white: 0.9))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Button(action: {
                        // Future implementation for selecting friends to share with
                    }) {
                        Text("Doing this with...")
                            .font(.custom("Chalkboard SE", size: 18))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("primaryMauve"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }.padding(.top, 16)
                }
                .padding([.leading, .trailing], 8) 
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                    .font(.custom("Chalkboard SE", size: 18))
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newTask = Task(title: title, description: description, time: time, sharedWith: [])
                        tasks.append(newTask)
                        isPresented = false
                    }
                    .font(.custom("Chalkboard SE", size: 18))
                }
            }
        }
    }
}


struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .foregroundColor(.white)
                    .imageScale(.large)
                configuration.label
            }
        }
    }
}


struct TaskCard: View {
    var task: Task
    @State private var isCompleted = false

    var body: some View {
        HStack {
            Toggle(isOn: $isCompleted) {
                VStack(alignment: .leading) {
                    Text(task.title)
                        .font(.custom("Chalkboard SE", size: 18))
                        .foregroundColor(.white)
                    Text(task.description)
                        .font(.custom("Chalkboard SE", size: 16))
                        .foregroundColor( .white.opacity(0.7))
                    if !task.sharedWith.isEmpty {
                        Text("Doing with: \(task.sharedWith.joined(separator: ", "))")
                            .font(.custom("Chalkboard SE", size: 14))
                            .foregroundColor(.white.opacity(0.5))
                    }
                }
            }
            .toggleStyle(CheckboxToggleStyle())
            Spacer()
            Text(task.time, style: .time)
                .foregroundColor(.white)
                .font(.custom("Chalkboard SE", size: 16))
        }
        .padding()
        .background(isCompleted ? Color("secondaryLilac") : Color("primaryMauve"))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
struct DailyTaskView_Previews: PreviewProvider {
    static var previews: some View {
        DailyTaskView()
    }
}

