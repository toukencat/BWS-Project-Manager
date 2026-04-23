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
    @State private var projectList: [Project] = []
    
    var body: some View {
         NavigationStack {
            ZStack {
                // Background color
                Color(red: 250/255, green: 250/255, blue: 245/255) // off-white
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    // Title
                    Text("Project Manager")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 50)
                    
                    Spacer()
                    
                    // Buttons
                    VStack(spacing: 20) {
                        MenuButton(title: "New Project", destination: NewProjectView())
                        
                        MenuButton(title: "Current Projects", destination: CurrentProjectsView(projects: $projectList))
                        
                        MenuButton(title: "Completed Projects", destination: EmptyView())
                        
                        MenuButton(title: "Messaging", destination: EmptyView())
                    }
                    .padding(.horizontal, 40)
                    .frame(maxHeight: .infinity)
                    Spacer()
                }
            }
        }
    }
}

// Reusable button component
struct MenuButton<Destination: View>: View {
    let title: String
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(red: 128/255, green: 0/255, blue: 32/255)) // burgundy wine
                .foregroundColor(.white)
                .cornerRadius(15)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
