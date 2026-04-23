//
//  NewTaskPopUp.swift
//  BWS Project Planner
//
//  Created by Spencer Blunt on 4/22/26.
//

import SwiftUI
import SwiftData

struct NewTaskModalView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var tasks: [Task]
    @Binding var isModalPresented: Bool
    
    // State Variables
    @State private var taskTitle: String = ""
    @State private var selectedTaskType: String = "Completion"
    @State private var selectedNumber: Int = 0
    @State private var selectedTaskCompleted: Bool = false
    @State private var taskDescription: String = "Enter description here..."
    
    let taskTypes = ["Completion", "Numerical"]
    
    var body: some View {
        // Background
        VStack {
            // Task Title
            TextField("Task Title", text: $taskTitle)
                .padding()
                .background(Color.white.opacity(0.5))
                .cornerRadius(10)
                .foregroundColor(.white)
                .font(.title3)
                .padding(.top)
            
            // Task Type Picker
            Picker("Task Type", selection: $selectedTaskType) {
                ForEach(taskTypes, id: \.self) { type in
                    Text(type)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(10)
            .foregroundColor(.white)
            .padding(.horizontal)
            
            // Number Picker if "Numerical" selected
            if selectedTaskType == "Numerical" {
                Picker("Select Number", selection: $selectedNumber) {
                    ForEach(0..<101) { number in
                        Text("\(number)")
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding(.horizontal)
            } else if selectedTaskType == "Completion" {
                Button(action: {
                    selectedTaskCompleted.toggle()
                }) {
                    HStack {
                        Text("Task Completed")
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Image(systemName: selectedTaskCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(selectedTaskCompleted ? .green : .white)
                    }
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            
            // Task Description
            TextEditor(text: $taskDescription)
                .scrollContentBackground(.hidden)
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)
                .foregroundColor(.white)
                .font(.body)
                .lineLimit(5)
                .padding(.horizontal)
                .frame(height: 150)
            
            // Save and Close Buttons
            HStack {
                Button(action: {
                    let newTask = Task(
                        title: taskTitle,
                        type: selectedTaskType,
                        descriptionText: taskDescription,
                        isCompleted: selectedTaskCompleted,
                        expectedValue: selectedTaskType == "Numerical" ? selectedNumber : nil,
                        currentValue: 0
                    )
                    
                    tasks.append(newTask)
                    selectedTaskCompleted = false
                    taskTitle = ""
                    taskDescription = ""
                    isModalPresented = false
                }) {
                    Text("Save Task")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                
                Button(action: {
                    self.isModalPresented = false
                }) {
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .frame(maxWidth: 400)
        .frame(maxHeight: 600)
        .background(Color.black.opacity(0.8))
        .cornerRadius(20)
        .shadow(radius: 20)
        .padding()
    }
}

struct NewTaskModalView_Previews: PreviewProvider {
    @State static var tasksPreview: [Task] = []
    @State static var modalPresented: Bool = true

    static var previews: some View {
        NewTaskModalView(
            tasks: $tasksPreview,
            isModalPresented: $modalPresented
        )
    }
}
