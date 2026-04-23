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
    @Binding var tasks: [ProjectTask]
    @Binding var isModalPresented: Bool
    
    // State Variables
    @State private var taskTitle: String = ""
    @State private var selectedTaskType: String = "Completion"
    @State private var selectedNumber: Int = 0
    @State private var selectedTaskCompleted: Bool = false
    @State private var descriptionText: String = "Enter description here..."
    
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
            } else {
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
            TextEditor(text: $descriptionText)
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
                Button("Save Task") {
                    let newTask = ProjectTask(
                        title: taskTitle,
                        type: selectedTaskType,
                        descriptionText: descriptionText,
                        isCompleted: selectedTaskCompleted,
                        expectedValue: selectedTaskType == "Numerical" ? selectedNumber : nil,
                        currentValue: 0
                    )
                    tasks.append(newTask)
                    resetForm()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(15)
                
                Button("Cancel") {
                    isModalPresented = false
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(15)
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .frame(maxWidth: 400, maxHeight: 600)
        .background(Color.black.opacity(0.8))
        .cornerRadius(20)
        .shadow(radius: 20)
        .padding()
    }
    private func resetForm() {
            selectedTaskCompleted = false
            taskTitle = ""
            descriptionText = ""
            selectedNumber = 0
            isModalPresented = false
        }
}

struct NewTaskModalView_Previews: PreviewProvider {
    @State static var tasksPreview: [ProjectTask] = []
    @State static var modalPresented: Bool = true

    static var previews: some View {
        NewTaskModalView(
            tasks: $tasksPreview,
            isModalPresented: $modalPresented
        )
    }
}
