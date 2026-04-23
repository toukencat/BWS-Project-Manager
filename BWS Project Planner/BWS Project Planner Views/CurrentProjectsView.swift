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
    
    var body: some View {
        ZStack(alignment: .top) {
            // Background
            Color(red: 128/255, green: 0/255, blue: 32/255)
                .edgesIgnoringSafeArea(.all)
            
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
                            Text(project.title)
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(red: 250/255, green: 250/255, blue: 245/255))
                                .cornerRadius(12)
                                .listRowInsets(EdgeInsets())
                                .padding(.vertical, 5)
                                .listRowBackground(Color.clear)
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
