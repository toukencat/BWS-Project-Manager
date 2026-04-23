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
    @State private var tasks: [Task] = []
    
    // Date Selection
    @State private var selectedMonthIndex: Int = Calendar.current.component(.month, from: Date()) - 1
    @State private var selectedDay: Int = Calendar.current.component(.day, from: Date())
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    
    // Project type and priority options
    private let projectTypes = ["Client Event", "Team Event", "Office Planning", "Other"]
    private let priorityLevels = ["High", "Medium", "Low"]
    
    // Date components for scroll pickers
    private let months = Calendar.current.monthSymbols
    private let years = Array(Calendar.current.component(.year, from: Date())...(Calendar.current.component(.year, from: Date()) + 10))
    private let days = Array(1...31)
    
    private func saveProject() {
        let newProject = Project(
            title: projectTitle,
            dueDate: dueDate,
            projectType: selectedProjectType,
            priority: selectedPriority
        )
        
        context.insert(newProject)
        
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
            
            VStack(spacing: 15) {
                // User Editable Project Title
                TextField("Project Title", text: $projectTitle)
                    .frame(maxWidth: .infinity)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
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
                            ForEach(1...31, id: \.self) { day in
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
                                Text("\(year)").tag(year)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 70, height: 150)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .accentColor(.white)
                    }
                    .padding(.horizontal)
                }
                                
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
                
                Spacer()
                
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
                    
                    Button(action: { /* Assign Task action */ }) {
                        Text("Assign Task")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 250/255, green: 250/255, blue: 245/255))
                            .foregroundColor(.black)
                            .cornerRadius(15)
                    }
                    
                    Button(action: { /* Delete Task action */ }) {
                        Text("Delete Task")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 250/255, green: 250/255, blue: 245/255))
                            .foregroundColor(.black)
                            .cornerRadius(15)
                    }
                    
                    Button(action: saveProject) {
                        Text("Save Project")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
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
            let components = DateComponents(year: selectedYear, month: selectedMonthIndex + 1, day: selectedDay)
            if let newDate = Calendar.current.date(from: components) {
                dueDate = newDate
            }
        }
}

struct NewProjectView_Previews: PreviewProvider {
    static var previews: some View {
        NewProjectView()
    }
}

#Preview {
    NewProjectView()
}
