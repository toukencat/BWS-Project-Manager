//
//  ProjectView.swift
//  BWS Project Planner
//
//  Created by Spencer Blunt on 4/23/26.
//

import SwiftUI
import SwiftData

struct ProjectView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    let project: Project
    var currentValue: Int
    var expectedValue: Int
    var dismissProject: () -> Void
    
    var completionTasks: [ProjectTask] {
        (project.tasks).filter { $0.type == "Completion" }
    }
    
    var completedCount: Int {
        completionTasks.filter { $0.isCompleted }.count
    }
    
    var completionProgress: Double {
        guard !completionTasks.isEmpty else { return 0 }
        return Double(completedCount) / Double(completionTasks.count)
    }
    
    var numericalTasks: [ProjectTask] {
        project.tasks.filter { $0.type == "Numerical" }
    }

    func progress(for task: ProjectTask) -> Double {
        guard let current = task.currentValue,
              let max = task.expectedValue,
              max > 0 else { return 0 }

        return min(Double(current) / Double(max), 1.0)
    }
    
    // Project type Color mapping
    var projectColor: Color {
        switch project.projectType {
        case "Client Event": return .blue
        case "Team Event": return .purple
        case "Office Planning": return .pink
        default: return .orange
        }
    }
    
    var body: some View {
        ZStack {
            // Background
            Color(hex: "#70285b")
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                VStack(spacing: 5) {
                    HStack(spacing: 10) {
                        Text(project.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                    
                    Text("Created: \(project.dateCreated.formatted(date: .abbreviated, time: .omitted))")
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text("Due: \(project.dueDate.formatted(date: .abbreviated, time: .omitted))")
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.top, 20)
                
                // Dashboard screen
                VStack(spacing: 20) {
                    Text(project.projectType)
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                    
                    VStack(spacing: 12) {
                        
                        HStack(spacing: 10) {
                            // Project Completion Progress
                            ZStack {
                                Circle()
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 12)
                                                        
                                Circle()
                                    .trim(from: 0, to: completionProgress)
                                    .stroke(projectColor, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                                    .rotationEffect(.degrees(-90))
                                    .animation(.easeInOut, value: completionProgress)
                                                        
                                Text("\(Int(completionProgress * 100))%")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                            .frame(width: 110, height: 110)
                            
                            // Numerical widgets
                            if !numericalTasks.isEmpty {
                                HStack(spacing: 10) {
                                    ForEach(numericalTasks) { task in

                                        VStack(spacing: 6) {

                                            ZStack {
                                                Circle()
                                                    .stroke(Color.gray.opacity(0.3), lineWidth: 6)

                                                Circle()
                                                    .trim(from: 0, to: progress(for: task))
                                                    .stroke(projectColor, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                                                    .rotationEffect(.degrees(-90))
                                                    .animation(.easeInOut, value: progress(for: task))

                                                Text("\(Int(progress(for: task) * 100))%")
                                                    .font(.caption2)
                                                    .foregroundColor(.black)
                                            }
                                            .frame(width: 50, height: 50)

                                            Text(task.title)
                                                .font(.caption2)
                                                .foregroundColor(.black)
                                                .lineLimit(1)
                                        }
                                    }
                                }
                                .padding(10)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(15)
                            }
                        }
                        // Tasks to be completed list
                        ScrollView {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Tasks")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                                    
                                ForEach(completionTasks) { task in
                                    HStack {
                                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(projectColor)
                                        
                                        Text(task.title)
                                            .foregroundColor(.black)
                                        
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color.white.opacity(0.6))
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        task.isCompleted.toggle()
                                        try? context.save()
                                    }
                                }
                            }
                            .padding()
                        }
                        .frame(maxHeight: 250)
                        
                        .padding()
                        .background(Color(red: 250/255, green: 250/255, blue: 245/255))
                        .cornerRadius(25)
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                }
            }
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}

struct ProjectPreviewWrapper: View {
    
    var body: some View {
        // Create an in-memory ModelContainer for preview
        let container = try! ModelContainer(
            for: Project.self, ProjectTask.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        
        let context = container.mainContext
        
        // Create a mock project
        let project = Project(
            title: "Event Planning",
            dueDate: Date(),
            projectType: "Client Event",
            priority: "High",
            assignment: "All"
        )
        context.insert(project)
        
        // Create mock tasks
        let tasks = [
            ProjectTask(title: "Book venue", type: "Completion", isCompleted: true, currentValue: nil, project: project),
            ProjectTask(title: "Send invites", type: "Completion", isCompleted: false, currentValue: nil, project: project),
            ProjectTask(title: "Confirm catering", type: "Completion", isCompleted: false, currentValue: nil, project: project),
            ProjectTask(title: "Budget Tracking", type: "Numerical", isCompleted: false, expectedValue: 100, currentValue: 40, project: project)
        ]
        tasks.forEach { context.insert($0) }
        
        // Wrap ProjectView with dummy dismiss closure
        return ProjectView(
            project: project,
            currentValue: 40,
            expectedValue: 100,
            dismissProject: { /* no-op for preview */ }
        )
        .modelContainer(container)
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

struct ProjectPreviewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        ProjectPreviewWrapper()
    }
}
