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
    
    var completedProjects: [Project] {
        projects.filter { $0.isCompleted }
    }
    
    func projectTypeDistribution() -> [String: Int] {
        var typeCount: [String: Int] = ["Client Event": 0, "Team Event": 0, "Office Planning": 0, "Other": 0]
        for project in completedProjects {
            let type = project.projectType
            if typeCount.keys.contains(type) {
                typeCount[type, default: 0] += 1
            } else {
                typeCount["Other", default: 0] += 1
            }
        }
        return typeCount
    }
    
    func priorityDistribution() -> [String: Int] {
        var priorityCount: [String: Int] = ["High": 0, "Medium": 0, "Low": 0]
        for project in completedProjects {
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
                Text("Completed Projects")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)
                
                HStack(spacing: 20) {
                    PieChartView(
                        data: projectTypeDistribution().values.map { Double($0) },
                        labels: projectTypeDistribution().keys.map { $0 },
                        colors: [Color.blue, Color.purple, Color.pink, Color.orange]
                    )
                    .frame(width: 150, height: 150)
                    
                    PieChartView(
                        data: priorityDistribution().values.map { Double($0) },
                        labels: priorityDistribution().keys.map { $0 },
                        colors: [Color.red, Color.yellow, Color.green]
                    )
                    .frame(width: 150, height: 150)
                }
                
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

// PieSliceView
struct PieSliceView: View {
    var startAngle: Angle
    var endAngle: Angle
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let rect = geometry.frame(in: .local)
                let center = CGPoint(x: rect.midX, y: rect.midY)
                let radius = min(rect.width, rect.height) / 2
                path.move(to: center)
                path.addArc(center: center,
                            radius: radius,
                            startAngle: startAngle,
                            endAngle: endAngle,
                            clockwise: false)
            }
            .fill(color)
        }
    }
}

// PieChartView
struct PieChartView: View {
    var data: [Double]
    var labels: [String]
    var colors: [Color]
    
    private var slices: [(start: Double, end: Double, color: Color, label: String)] {
        var startAngle = 0.0
        let total = data.reduce(0, +)
        var result: [(Double, Double, Color, String)] = []
        for i in 0..<data.count {
            let angle = data[i] / total * 360
            result.append((start: startAngle, end: startAngle + angle, color: colors[i], label: labels[i]))
            startAngle += angle
        }
        return result
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<slices.count, id: \.self) { i in
                    PieSliceView(
                        startAngle: Angle(degrees: slices[i].start),
                        endAngle: Angle(degrees: slices[i].end),
                        color: slices[i].color
                    )
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    
                    let midAngle = (slices[i].start + slices[i].end) / 2
                    Text(slices[i].label)
                        .foregroundColor(.white)
                        .font(.caption)
                        .bold()
                        .position(
                            x: geometry.size.width / 2 + (geometry.size.width / 3) * CGFloat(cos(midAngle * .pi / 180)),
                            y: geometry.size.height / 2 + (geometry.size.width / 3) * CGFloat(sin(midAngle * .pi / 180))
                        )
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct CompletedProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        // Mock Projects
        let project1 = Project(
            title: "Client Event 1",
            dueDate: Date(),
            projectType: "Client Event",
            priority: "High",
            assignment: "T"
        )
        let project2 = Project(
            title: "Team Event 1",
            dueDate: Date(),
            projectType: "Team Event",
            priority: "Medium",
            assignment: "V"
        )
        let project3 = Project(
            title: "Office Planning 1",
            dueDate: Date(),
            projectType: "Office Planning",
            priority: "Low",
            assignment: "C"
        )
        let project4 = Project(
            title: "Other Event 1",
            dueDate: Date(),
            projectType: "Other",
            priority: "Medium",
            assignment: "All"
        )
        
        // Add tasks to each project
        project1.tasks = [
            Task(title: "Task 1", isCompleted: true, currentValue: nil, project: project1),
            Task(title: "Task 2", isCompleted: true, currentValue: nil, project: project1)
        ]
        project2.tasks = [
            Task(title: "Task 1", isCompleted: true, currentValue: nil, project: project2),
            Task(title: "Task 2", isCompleted: true, currentValue: nil, project: project2)
        ]
        project3.tasks = [
            Task(title: "Task 1", isCompleted: true, currentValue: nil, project: project3),
            Task(title: "Task 2", isCompleted: true, currentValue: nil, project: project3)
        ]
        project4.tasks = [
            Task(title: "Task 1", isCompleted: true, currentValue: nil, project: project4),
            Task(title: "Task 2", isCompleted: true, currentValue: nil, project: project4)
        ]
        
        let mockProjects = [project1, project2, project3, project4]
        
        return CompletedProjectsView(projects: mockProjects)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
