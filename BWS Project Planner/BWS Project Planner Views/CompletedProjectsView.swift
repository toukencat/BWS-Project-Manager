//
//  CompletedProjectsView.swift
//  BWS Project Planner
//
//  Created by Spencer Blunt on 4/23/26.
//

import SwiftUI
import SwiftData

struct CompletedProjectsView: View {
    var projects: [Project]
    
    // Function to calculate the total count for each project type
    func projectTypeDistribution() -> [String: Int] {
        var typeCount: [String: Int] = ["Client Event": 0, "Team Event": 0, "Office Planning": 0, "Other": 0]
        
        for project in projects {
            let type = project.projectType
            if typeCount.keys.contains(type) {
                typeCount[type, default: 0] += 1
            } else {
                typeCount["Other", default: 0] += 1
            }
        }
        return typeCount
    }
    
    // Function to calculate the total count for each priority level
    func priorityDistribution() -> [String: Int] {
        var priorityCount: [String: Int] = ["High": 0, "Medium": 0, "Low": 0]

        for project in projects {
            let completedTasks = project.tasks.filter { $0.isCompleted }
            let priority = project.priority
            if !completedTasks.isEmpty && priorityCount.keys.contains(priority) {
                priorityCount[priority, default: 0] += 1
            }
        }
        return priorityCount
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Title
                Text("Completed Projects")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)

                // Pie Chart for Project Type Distribution
                PieChartView(data: projectTypeDistribution().values.map { Double($0) }, labels: projectTypeDistribution().keys.map { $0 }, colors: [
                    Color.blue, Color.purple, Color.pink, Color.orange
                ])
                .frame(width: 300, height: 300)
                .padding()

                // Pie Chart for Priority Distribution
                PieChartView(data: priorityDistribution().values.map { Double($0) }, labels: priorityDistribution().keys.map { $0 }, colors: [
                    Color.red, Color.yellow, Color.green
                ])
                .frame(width: 300, height: 300)
                .padding()
            
                // List of Completed Projects
                Text("Projects with All Tasks Completed")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.top, 20)

                ForEach(projects.filter { $0.tasks.allSatisfy { $0.isCompleted } }) { project in
                    VStack(alignment: .leading) {
                        Text(project.title)
                            .font(.body)
                            .fontWeight(.semibold)
            
                        Text("Project Type: \(project.projectType)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.white.opacity(0.6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
            }
            .padding()
        }
    }
}

// Custom Pie Slice View to Draw Each Slice of the Pie
struct PieSliceView: View {
    var startAngle: Angle
    var endAngle: Angle
    var color: Color

    var body: some View {
        Path { path in
            path.move(to: .zero)
            path.addArc(center: .zero, radius: 1, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
        .fill(color)
        .rotationEffect(Angle(degrees: -90)) // To start the pie chart from the top
        .offset(x: 150, y: 150) // Offset to center the pie chart
    }
}

// Custom Pie Chart View that Uses PieSliceView to Draw Pie Chart
struct PieChartView: View {
    var data: [Double]
    var labels: [String]
    var colors: [Color]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let total = data.reduce(0, +)
                var startAngle = 0.0
                
                ForEach(0..<data.count, id: \.self) { i in
                    let angle = data[i] / total * 360
                    let endAngle = startAngle + angle
                    
                    // Draw each pie slice
                    PieSliceView(startAngle: Angle(degrees: startAngle), endAngle: Angle(degrees: endAngle), color: colors[i])
                        .frame(width: geometry.size.width, height: geometry.size.width)
                    startAngle = endAngle
                }
                
                // Add labels for each slice
                startAngle = 0.0
                ForEach(0..<data.count, id: \.self) { i in
                    Text(labels[i])
                        .foregroundColor(.white)
                        .font(.caption)
                        .bold()
                        .offset(x: (geometry.size.width / 3) * cos((startAngle + (data[i] / total) * 180) * .pi / 180),
                                y: (geometry.size.width / 3) * sin((startAngle + (data[i] / total) * 180) * .pi / 180))
                    startAngle += data[i] / total * 360
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct CompletedProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        // Mock data for preview
        let mockProjects: [Project] = [
            Project(title: "Client Event 1",
                    dueDate: Date(), 
                    projectType: "Client Event",
                    priority: "High",
                    assignment: "T"),

            Project(title: "Team Event 1",
                    dueDate: Date(),
                    projectType: "Team Event",
                    priority: "Medium",
                    assignment: "V"),

            Project(title: "Office Planning 1",
                    dueDate: Date(),
                    projectType: "Office Planning",
                    priority: "Low",
                    assignment: "C"),

            Project(title: "Other Event 1",
                    dueDate: Date(),
                    projectType: "Other",
                    priority: "Medium",
                    assignment: "All")
        ]
        
        let projectsWithTasks = mockProjects
        
        // Add tasks to each project
        projectsWithTasks[0].tasks.append(Task(title: "Task 1", isCompleted: true, currentValue: nil, project: projectsWithTasks[0]))
        projectsWithTasks[0].tasks.append(Task(title: "Task 2", isCompleted: true, currentValue: nil, project: projectsWithTasks[0]))
        
        projectsWithTasks[1].tasks.append(Task(title: "Task 1", isCompleted: true, currentValue: nil, project: projectsWithTasks[1]))
        projectsWithTasks[1].tasks.append(Task(title: "Task 2", isCompleted: true, currentValue: nil, project: projectsWithTasks[1]))
        
        projectsWithTasks[2].tasks.append(Task(title: "Task 1", isCompleted: true, currentValue: nil, project: projectsWithTasks[2]))
        projectsWithTasks[2].tasks.append(Task(title: "Task 2", isCompleted: true, currentValue: nil, project: projectsWithTasks[2]))
        
        projectsWithTasks[3].tasks.append(Task(title: "Task 1", isCompleted: true, currentValue: nil, project: projectsWithTasks[3]))
        projectsWithTasks[3].tasks.append(Task(title: "Task 2", isCompleted: true, currentValue: nil, project: projectsWithTasks[3]))

        // Return CompletedProjectsView with mock projects
        return CompletedProjectsView(projects: projectsWithTasks)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
