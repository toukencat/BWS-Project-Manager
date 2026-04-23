//
//  HomeView.swift
//  BWS Project Planner
//
//  Created by Spencer Blunt on 4/22/26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query var projects: [Project]
    
    @State private var showCurrentProjects = false
    @State private var showCompletedProjects = false
    @State private var showNewProject = false
    @State private var showMessaging = false
    
    var body: some View {
        ZStack {
            Color(red: 250/255, green: 250/255, blue: 245/255)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Project Manager")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)
                
                Spacer()
                
                VStack(spacing: 20) {
                    Button("New Project") { showNewProject = true }
                        .menuButtonStyle()
                    
                    Button("Current Projects") { showCurrentProjects = true }
                        .menuButtonStyle()
                    
                    Button("Completed Projects") { showCompletedProjects = true }
                        .menuButtonStyle()
                    
                    Button("Messaging") { showMessaging = true }
                        .menuButtonStyle()
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
        }
        .sheet(isPresented: $showNewProject) {
            NewProjectView()
        }
        .sheet(isPresented: $showCurrentProjects) {
            CurrentProjectsView(projects: .constant(projects))
        }
        .sheet(isPresented: $showCompletedProjects) {
            CompletedProjectsView(projects: projects)
        }
        .sheet(isPresented: $showMessaging) {
            ChatBotView()
        }
    }
}

// Reusable button style
extension View {
    func menuButtonStyle() -> some View {
        self
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(hex: "#70285b"))
            .foregroundColor(.white)
            .cornerRadius(15)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
