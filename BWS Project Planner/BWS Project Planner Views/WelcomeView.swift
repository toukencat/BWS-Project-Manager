//
//  WelcomeView.swift
//  BWS Project Planner
//
//  Created by Spencer Blunt on 4/22/26.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack{
            Image("BWSlogo")
            Text("Project Manager")
                .font(.caption)
                .fontWeight(.medium)
        }
        .padding()
    }
}

#Preview {
    WelcomeView()
}
