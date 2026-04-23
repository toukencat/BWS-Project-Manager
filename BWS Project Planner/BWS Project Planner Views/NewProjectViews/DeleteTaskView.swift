//
//  DeleteTaskView.swift
//  BWS Project Planner
//
//  Created by Spencer Blunt on 4/22/26.
//

import SwiftUI
import SwiftData

struct DeleteTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @Binding var tasks: [Task]
    
    var body: some View {
        ZStack(alignment: .top) {
            // Background
            Color(red: 128/255, green: 0/255, blue: 32/255)
                .edgesIgnoringSafeArea(.all)
            
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
                Text("Delete Task")
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
        for index in offsets {
            let task = tasks[index]
            if task.modelContext != nil {
                context.delete(task)
            }
        }
        tasks.remove(atOffsets: offsets)
    }
}

#Preview {
    DeleteTaskPreviewWrapper()
}

struct DeleteTaskPreviewWrapper: View {
    @State private var tasks: [Task] = [
        Task(title: "Book venue"),
        Task(title: "Send invitations"),
        Task(title: "Confirm catering")
    ]
    
    var body: some View {
        DeleteTaskView(tasks: $tasks)
    }
}
