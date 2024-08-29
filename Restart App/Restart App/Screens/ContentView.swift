//
//  ContentView.swift
//  Restart App
//
//  Created by Oğuz Kurtoğlu on 28.08.2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    var body: some View {
        ZStack {
            if isOnboardingViewActive{
                OnboardingView()
            }
            else{
                HomeView()
            }
        } 
        .animation(.easeOut(duration:0.5), value: isOnboardingViewActive)

    }
}

#Preview {
    ContentView()
}
