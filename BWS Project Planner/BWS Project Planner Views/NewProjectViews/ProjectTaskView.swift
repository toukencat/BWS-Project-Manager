//
//  DeleteTaskView.swift
//  BWS Project Planner
//
//  Created by Spencer Blunt on 4/22/26.
//

import SwiftUI
import SwiftData

struct ProjectTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @Binding var tasks: [ProjectTask]
    
    var body: some View {
        ZStack(alignment: .top) {
            // Background
            Color(hex: "#70285b")
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                
                Spacer().frame(height: 60)
                
                if tasks.isEmpty {
                    Spacer()
                    Text("No Tasks Available")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.headline)
                    Spacer()
                } else {
                    List {
                        ForEach(tasks) { task in
                            Text(task.title)
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(red: 250/255, green: 250/255, blue: 245/255))
                                .cornerRadius(12)
                                .listRowInsets(EdgeInsets())
                                .padding(.vertical, 5)
                                .listRowBackground(Color.clear)
                        }
                        .onDelete(perform: deleteTask)
                    }
                    .scrollContentBackground(.hidden)
                    .padding(.horizontal)
                }
                
                Spacer()
            }
                
            HStack {
                Text("Task List")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }) {
                    Text("X")
                         .foregroundColor(.white)
                         .font(.headline)
                         .padding(8)
                         .background(Color.white.opacity(0.2))
                         .clipShape(Circle())
                }
            }
            .padding(.horizontal)
            .padding(.top, 50)
        }
    }
    
    private func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

#Preview {
    TaskPreviewWrapper()
}


struct TaskPreviewWrapper: View {
    @State private var tasks: [ProjectTask] = [
        ProjectTask(title: "Book venue", type: "Completion", descriptionText: "", isCompleted: false, expectedValue: nil, currentValue: nil),
        ProjectTask(title: "Send invitations", type: "Completion", descriptionText: "", isCompleted: true, expectedValue: nil, currentValue: nil),
        ProjectTask(title: "Confirm catering", type: "Completion", descriptionText: "", isCompleted: false, expectedValue: nil, currentValue: nil)
    ]
        
    var body: some View {
        ProjectTaskView(tasks: $tasks)
            .modelContainer(for: ProjectTask.self, inMemory: true)
        }
    }
