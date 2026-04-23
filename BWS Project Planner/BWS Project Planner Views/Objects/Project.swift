//
//  ProjectObject.swift
//  BWS Project Planner
//
//  Created by Spencer Blunt on 4/22/26.
//

import Foundation
import SwiftData

@Model
class Project: Identifiable {
    @Attribute(.unique) var id: UUID = UUID()
    var title: String
    var dateCreated: Date
    var dueDate: Date
    var projectType: String
    var priority: String
    var assignment: String
    
    @Relationship var tasks: [ProjectTask] = []
    
    var isCompleted: Bool {
        !tasks.isEmpty && tasks.allSatisfy { $0.isCompleted }
    }
    
    init(title: String,
         dateCreated: Date = Date(),
         dueDate: Date,
         projectType: String,
         priority: String,
         assignment: String) {
        
        self.title = title
        self.dateCreated = dateCreated
        self.dueDate = dueDate
        self.projectType = projectType
        self.priority = priority
        self.assignment = assignment
    }
}
