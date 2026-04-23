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
    var number: Int?          // optional
    @Relationship var project: Project?
    
    init(title: String, type: String = "Completion", descriptionText: String = "", number: Int? = nil, project: Project? = nil) {
        self.title = title
        self.type = type
        self.descriptionText = descriptionText
        self.number = number
        self.project = project
    }
}
