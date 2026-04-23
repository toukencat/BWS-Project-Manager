//
//  CurrentProjectsView.swift
//  BWS Project Planner
//
//  Created by Spencer Blunt on 4/23/26.
//

import SwiftUI
import SwiftData

struct CurrentProjectsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @Binding var projects: [Project]
    
    @State private var selectedProject: Project?
    
    var currentProjects: [Project] {
        projects.filter { !$0.isCompleted }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            // Background
            Color(hex: "#70285b")
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                
                Spacer().frame(height: 60)
                
                if projects.isEmpty {
                    Spacer()
                    Text("No Projects To Do")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.headline)
                    Spacer()
                } else {
                    List {
                        ForEach(projects) { project in
                            Button(action: {
                                selectedProject = project
                            }) {
                                VStack(alignment: .leading) {
                                    Text(project.title)
                                        .foregroundColor(.black)
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color(red: 250/255, green: 250/255, blue: 245/255))
                                        .cornerRadius(12)
                                                            
                                    Divider()
                                        .padding(.top, 5)
                                }
                                .padding(.vertical, 5)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .onDelete(perform: deleteProject)
                    }
                    .scrollContentBackground(.hidden)
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            
            // Title and Exit Button
            HStack {
                Text("Current Projects")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }) {
                    Text("X")
                         .foregroundColor(.white)
                         .font(.headline)
                         .padding(8)
                         .background(Color.white.opacity(0.2))
                         .clipShape(Circle())
                }
            }
            .padding(.horizontal)
            .padding(.top, 50)
        }
        .sheet(item: $selectedProject) { project in
            let currentValue = project.tasks.filter { $0.type == "Numerical" }.map { $0.currentValue ?? 0 }.reduce(0, +)
            let expectedValue = project.tasks.filter { $0.type == "Numerical" }.map { $0.expectedValue ?? 0 }.reduce(0, +)
                    
            ProjectView(project: project, currentValue: currentValue, expectedValue: expectedValue, dismissProject: { selectedProject = nil })
        }
    }
    
    private func deleteProject(at offsets: IndexSet) {
        for index in offsets {
            let project = projects[index]
                context.delete(project)
        }
        projects.remove(atOffsets: offsets)
    }
}

#Preview {
    CurrentProjectsPreviewWrapper()
}

struct CurrentProjectsPreviewWrapper: View {
    @State private var projects: [Project] = [
        Project(title: "Website Redesign",
                dueDate: Date(),
                projectType: "Client Event",
                priority: "High",
                assignment: "All"),
        
        Project(title: "Office Setup",
                dueDate: Date(),
                projectType: "Office Planning",
                priority: "Medium",
                assignment: "All"),
        
        Project(title: "Marketing Campaign",
                dueDate: Date(),
                projectType: "Team Event",
                priority: "Low",
                assignment: "All")
    ]
    
    var body: some View {
        CurrentProjectsView(projects: $projects)
            .modelContainer(for: Project.self, inMemory: true)
    }
}
