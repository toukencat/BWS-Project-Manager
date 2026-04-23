//
//  NewProjectView.swift
//  BWS Project Planner
//
//  Created by Spencer Blunt on 4/22/26.
//
import SwiftUI
import SwiftData

struct NewProjectView: View {
    
    // State Variables
    @State private var projectTitle: String = "New Project"
    @State private var dueDate: Date = Date()
    @State private var selectedProjectType: String = "Client Event"
    @State private var selectedPriority: String = "High"
    
    // Project type and priority options
    let projectTypes = ["Client Event", "Team Event", "Office Planning", "Other"]
    let priorityLevels = ["High", "Medium", "Low"]
    
    var body: some View {
        ZStack {
            // Background
            Color(red: 128/255, green: 0/255, blue: 32/255) // burgundy wine
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                // User Editable Project Title
                TextField("Project Title", text: $projectTitle)
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
                
                // User Editable Date Due
                VStack(alignment: .leading, spacing: 5) {
                    Text("Date Due:")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    DatePicker(
                        "",
                        selection: $dueDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    .accentColor(.white)
                }
                .padding(.horizontal)
                
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
                
                // Bottom Buttons
                VStack(spacing: 15) {
                    Button(action: { /* New Task action */ }) {
                        Text("New Task")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 250/255, green: 250/255, blue: 245/255)) // off-white
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
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
    }
}

struct NewProjectView_Previews: PreviewProvider {
    static var previews: some View {
        NewProjectView()
    }
}
