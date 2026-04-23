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
    
    // State Variables
    @Binding var isModalPresented: Bool // Binding to control the visibility of the modal
    @State private var taskTitle: String = ""
    @State private var selectedTaskType: String = "Completion"
    @State private var selectedNumber: Int = 0
    @State private var taskDescription: String = "Enter description here..."
    
    let taskTypes = ["Completion", "Numerical"]
    var number: Int?
    
    
    var body: some View {
        // Background
        VStack {
            // Task Title
            TextField("Task Title", text: $taskTitle)
                .padding()
                .background(Color.white.opacity(0.2))
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
            }
            
            // Task Description
            TextField("Enter description here...", text: $taskDescription)
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
                        number: selectedTaskType == "Numerical" ? selectedNumber : nil
                    )
                    
                    tasks.append(newTask)
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
