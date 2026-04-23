//
//  ChatBotView.swift
//  BWS Project Planner
//
//  Created by Spencer Blunt on 4/23/26.
//

import Foundation
import SwiftUI
import SwiftData

struct ChatBotView: View {
    @StateObject private var service = ChatBotService()
    @State private var inputText = ""
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(service.messages) { message in
                        HStack {
                            if message.isUser { Spacer() }
                            Text(message.text)
                                .padding()
                                .background(message.isUser ? Color.blue : Color.gray.opacity(0.4))
                                .foregroundColor(message.isUser ? .white : .black)
                                .cornerRadius(10)
                            if !message.isUser { Spacer() }
                        }
                    }
                }
                .padding()
            }
            
            HStack {
                TextField("Type a message...", text: $inputText)
                    .textFieldStyle(.roundedBorder)
                
                Button("Send") {
                    Task {
                        await service.sendMessage(inputText)
                        inputText = ""
                    }
                }
            }
            .padding()
        }
    }
}
