//
//  TaskObject.swift
//  BWS Project Planner
//
//  Created by Spencer Blunt on 4/22/26.
//

import Foundation
import SwiftData

@Model
class Task: Identifiable {
    var title: String
    var type: String
    var descriptionText: String
    var isCompleted: Bool
    var expectedValue: Int?
    var currentValue: Int?
    @Relationship(inverse: \Project.tasks) var project: Project?
    
    init(title: String, type: String = "Completion", descriptionText: String = "", isCompleted: Bool, expectedValue: Int? = nil, currentValue: Int?, project: Project? = nil) {
        self.title = title
        self.type = type
        self.descriptionText = descriptionText
        self.isCompleted = isCompleted
        self.expectedValue = expectedValue
        self.currentValue = currentValue
        self.project = project
    }
}
