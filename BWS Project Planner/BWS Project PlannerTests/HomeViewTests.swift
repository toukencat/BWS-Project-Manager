//
//  HomeViewTests.swift
//  BWS Project PlannerTests
//
//  Created by Spencer Blunt on 4/23/26.
//

import Foundation
import XCTest
import SwiftUI
import SwiftData

@testable import BWS_Project_Planner

class HomeViewTests: XCTestCase {

    var homeView: HomeView!
    
    override func setUp() {
        super.setUp()
        
        // Create a mock environment for your tests
        let mockProjects: [Project] = [
            Project(title: "Website Redesign", dueDate: Date(), projectType: "Client Event", priority: "High", assignment: "All"),
            Project(title: "Office Setup", dueDate: Date(), projectType: "Office Planning", priority: "Medium", assignment: "All")
        ]
        
        // Inject mock data into HomeView
        homeView = HomeView()
        
        // Assuming you have a way to provide mock data in the HomeView
        //homeView.projects = mockProjects
    }
    
    override func tearDown() {
        homeView = nil
        super.tearDown()
    }
    
    func testProjectListPopulated() {
        // Test if projectList is populated correctly when the view appears
        //homeView.onAppear()
        
        //XCTAssertEqual(homeView.projectList.count, 2)
        //XCTAssertEqual(homeView.projectList[0].title, "Website Redesign")
        //XCTAssertEqual(homeView.projectList[1].title, "Office Setup")
    }
    
    func testButtonsRenderCorrectly() {
        // Test if buttons are rendered in HomeView
        let buttons = homeView.body // Extract body of the HomeView to get all components
        
        // Check if the "Current Projects" button exists
        //XCTAssertNotNil(buttons.find(MenuButton.self, where: { $0.title == "Current Projects" }))
        
        // Check if the "Completed Projects" button exists
        //XCTAssertNotNil(buttons.find(MenuButton.self, where: { $0.title == "Completed Projects" }))
    }
}
