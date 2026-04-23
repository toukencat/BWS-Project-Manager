//
//  TaskObject.swift
//  BWS Project Planner
//
//  Created by Spencer Blunt on 4/22/26.
//

import Foundation
import SwiftData

@Model
class Task {
    var title: String
    @Relationship(.cascade) var project: Project?

    init(title: String, project: Project? = nil) {
        self.title = title
        self.project = project
    }
}
