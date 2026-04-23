//
//  File.swift
//  BWS Project Planner
//
//  Created by Spencer Blunt on 4/23/26.
//

import Foundation
import SwiftUI
import Combine

class ChatBotService: ObservableObject {
    @Published var messages: [ChatMessage] = []
    
    struct ChatMessage: Identifiable {
        let id = UUID()
        let text: String
        let isUser: Bool
    }
    
    func sendMessage(_ text: String) async {
        // Add user message
        DispatchQueue.main.async {
            self.messages.append(ChatMessage(text: text, isUser: true))
        }
        
        // Prepare API request
        guard let url = URL(string: "https://api.example.com/chat") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["message": text]
        request.httpBody = try? JSONEncoder().encode(body)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let response = try? JSONDecoder().decode(Response.self, from: data) {
                DispatchQueue.main.async {
                    self.messages.append(ChatMessage(text: response.reply, isUser: false))
                }
            }
        } catch {
            print("Error sending message: \(error)")
        }
    }
    
    struct Response: Decodable {
        let reply: String
    }
}
