//
//  OnboardingView.swift
//  Restart App
//
//  Created by Oğuz Kurtoğlu on 29.08.2024.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    var body: some View {
        
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            VStack(spacing:20) {
                Spacer()
                
                VStack(spacing:0){
                    Text("Share.")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text("""
                    It's not how much we give but
                    how much love we put into giving.
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                }
                // Character
                ZStack{
                    CircleGroupView(shapeColor: .white, colorOpacity: 0.2)

                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                }
                Spacer()
                
                // Draggable
                ZStack{
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    HStack{
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: 80)
                        Spacer()

                    }
                    Text("Get Started")
                      .font(.system(.title3, design: .rounded))
                      .fontWeight(.bold)
                      .foregroundColor(.white)
                      .offset(x: 20)
                    
                    HStack {
                        ZStack{
                            Circle()
                              .fill(Color("ColorRed"))
                            Circle()
                              .fill(.black.opacity(0.15))
                              .padding(8)
                            Image(systemName: "chevron.right.2")
                              .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .onTapGesture {
                            isOnboardingViewActive = false
                            print("Clicked")
                        }
                        Spacer()
                    }
                    
                }
                .frame(height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding()
                
            } //: VStack
        } //: ZSTACK
        
    }
}

#Preview {
    OnboardingView()
}
