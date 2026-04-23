//
//  BWS_Project_PlannerApp.swift
//  BWS Project Planner
//
//  Created by Spencer Blunt on 4/18/26.
//

import SwiftUI
import SwiftData

@main
struct BWS_Project_PlannerApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: [Project.self, Task.self])
    }
}
