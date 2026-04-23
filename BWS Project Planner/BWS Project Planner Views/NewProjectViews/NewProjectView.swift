//
//  NewProjectView.swift
//  BWS Project Planner
//
//  Created by Spencer Blunt on 4/22/26.
//
import SwiftUI
import SwiftData

struct NewProjectView: View {
    
    // Environment
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    // State Variables
    @State private var projectTitle = "New Project"
    @State private var dueDate: Date = Date()
    @State private var selectedProjectType: String = "Client Event"
    @State private var selectedPriority: String = "High"
    @State private var isNewTaskModalPresented: Bool = false
    @State private var isDeleteTaskViewPresented = false
    @State private var tasks: [Task] = []
    @State private var selectedAssignee: String = "All"

    // Date Selection
    @State private var selectedMonthIndex: Int = Calendar.current.component(.month, from: Date()) - 1
    @State private var selectedDay: Int = Calendar.current.component(.day, from: Date())
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    
    // Project type, priority level, and asignment options
    private let projectTypes = ["Client Event", "Team Event", "Office Planning", "Other"]
    private let priorityLevels = ["High", "Medium", "Low"]
    private let assignees = ["D", "C", "J", "V", "Tammy", "All"]
    
    // Date components for scroll pickers
    private let months = Calendar.current.monthSymbols
    private let years = Array(Calendar.current.component(.year, from: Date())...(Calendar.current.component(.year, from: Date()) + 10))
    private let days = Array(1...31)
    var validDays: [Int] {
        let components = DateComponents(year: selectedYear, month: selectedMonthIndex + 1)
        
        guard
            let date = Calendar.current.date(from: components),
            let range = Calendar.current.range(of: .day, in: .month, for: date)
        else {
            return Array(1...31)
        }
        
        return Array(range)
    }
    
    private func saveProject() {
        let newProject = Project(
            title: projectTitle,
            dueDate: dueDate,
            projectType: selectedProjectType,
            priority: selectedPriority
        )
        
        context.insert(newProject)
        
        for task in tasks {
            task.project = newProject
            context.insert(task)
        }
        
        do {
            try context.save()
            dismiss() // optional: close view
        } catch {
            print("Failed to save project: \(error)")
        }
    }
    
    var body: some View {
        ZStack {
            // Background
            Color(red: 128/255, green: 0/255, blue: 32/255) // burgundy wine
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 15) {
                // User Editable Project Title
                TextField("Project Title", text: $projectTitle)
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(12)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding(.top, 10)
                
                // Date Created
                HStack {
                    Text("Date Created: ")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    Text(Date(), style: .date)
                        .foregroundColor(.white)
                }
                
                // User Date Due Picker
                VStack(alignment: .leading, spacing: 10) {
                    Text("Date Due:")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    
                    HStack {
                        // Month Picker
                        Picker("Month", selection: $selectedMonthIndex) {
                            ForEach(0..<months.count, id: \.self) { index in
                                Text(self.months[index]).tag(index)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 100, height: 150)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .accentColor(.white)
                        
                        // Day Picker
                        Picker("Day", selection: $selectedDay) {
                            ForEach(validDays, id: \.self) { day in
                                Text("\(day)").tag(day)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 50, height: 150)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .accentColor(.white)
                        // Year Picker
                        Picker("Year", selection: $selectedYear) {
                            ForEach(years, id: \.self) { year in
                                Text(String(year)).tag(year)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 100, height: 150)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .accentColor(.white)
                    }
                }
                .padding(.horizontal)
                
                HStack(spacing: 10) {
                    // Project Type Picker
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Project Type:")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        Picker("Select Project Type", selection: $selectedProjectType) {
                            ForEach(projectTypes, id: \.self) { type in
                                Text(type)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    
                    // Project Priority Picker
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Project Priority:")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        Picker("Select Priority", selection: $selectedPriority) {
                            ForEach(priorityLevels, id: \.self) { level in
                                Text(level)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    }
                    .padding(.horizontal)

                }
                // Project Assignment Picker
                VStack(alignment: .leading, spacing: 5) {
                    Text("Assign Task:")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    
                    Picker("Assign Task", selection: $selectedAssignee) {
                        ForEach(assignees, id: \.self) { person in
                            Text(person)
                        }
                    }
                    .pickerStyle(.menu)
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                }
                .padding(.horizontal)
                //Spacer()
                
                // Task Buttons
                VStack(spacing: 15) {
                // New Task Button
                    Button(action: {
                        self.isNewTaskModalPresented.toggle()
                    }) {
                        Text("New Task")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 250/255, green: 250/255, blue: 245/255))
                            .foregroundColor(.black)
                            .cornerRadius(15)
                    }
                    .sheet(isPresented: $isNewTaskModalPresented) {
                        NewTaskModalView(tasks: $tasks, isModalPresented: $isNewTaskModalPresented)
                    }
                    
                    Button(action: {
                        isDeleteTaskViewPresented = true
                    }) {
                        Text("Delete Task")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 250/255, green: 250/255, blue: 245/255))
                            .foregroundColor(.black)
                            .cornerRadius(15)
                    }
                    .sheet(isPresented: $isDeleteTaskViewPresented) {
                        DeleteTaskView(tasks: $tasks)
                    }
                    
                    Button(action: saveProject) {
                        Text("Save Project")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                    
                    Button(action: dismiss()) {
                        Text("Exit Project")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
            .padding(.bottom, 10)
        }
        .onChange(of: selectedMonthIndex) {
            updateDueDate()
        }
        .onChange(of: selectedDay) {
            updateDueDate()
        }
        .onChange(of: selectedYear) {
            updateDueDate()
        }
    }
    // Update the due date when the user selects a new date
    private func updateDueDate() {
        let maxDay = validDays.last ?? 31
        if selectedDay > maxDay {
            selectedDay = maxDay
        }
        
        let components = DateComponents(
            year: selectedYear,
            month: selectedMonthIndex + 1,
            day: selectedDay
        )
        
        if let newDate = Calendar.current.date(from: components) {
            dueDate = newDate
        }
    }
}

#Preview {
    NewProjectView()
}
