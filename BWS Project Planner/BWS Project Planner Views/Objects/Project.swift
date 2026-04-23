//
//  ProjectObject.swift
//  BWS Project Planner
//
//  Created by Spencer Blunt on 4/22/26.
//

import Foundation
import SwiftData

@Model
class Project {
    var title: String
    var dateCreated: Date
    var dueDate: Date
    var projectType: String
    var priority: String
    
    @Relationship var tasks: [Task] = []
    
    init(title: String,
         dateCreated: Date = Date(),
         dueDate: Date,
         projectType: String,
         priority: String) {
        
        self.title = title
        self.dateCreated = dateCreated
        self.dueDate = dueDate
        self.projectType = projectType
        self.priority = priority
    }
}
