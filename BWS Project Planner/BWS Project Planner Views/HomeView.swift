//
//  ContentView.swift
//  BWS Project Planner
//
//  Created by Spencer Blunt on 4/18/26.
//


import SwiftUI
import SwiftData

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color
                Color(red: 250/255, green: 250/255, blue: 245/255)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    Text("Project Home")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 50)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        MenuButton(title: "New Project", destination: EmptyView()) {
                            Text("Completed Projects")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 128/255, green: 0/255, blue: 32/255))
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                        
                        MenuButton(title: "Current Projects", destination: EmptyView()) {
                            Text("Completed Projects")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 128/255, green: 0/255, blue: 32/255))
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                        
                        MenuButton(title: "Completed Projects", destination: EmptyView()) {
                            Text("Completed Projects")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 128/255, green: 0/255, blue: 32/255))
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                        
                        MenuButton(title: "Messaging", destination: EmptyView()) {
                            Text("Completed Projects")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 128/255, green: 0/255, blue: 32/255))
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        }
                    }
                    .padding(.horizontal, 40)
                    
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
                .background(Color(red: 128/255, green: 0/255, blue: 32/255))
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
