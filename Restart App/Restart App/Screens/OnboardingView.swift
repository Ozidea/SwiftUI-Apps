//
//  OnboardingView.swift
//  Restart App
//
//  Created by Oğuz Kurtoğlu on 29.08.2024.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var imageOffset: CGSize = .zero
    @State private var isAnimating: Bool = false
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "Share."
    let hapticFeedback = UINotificationFeedbackGenerator()

    var body: some View {
        
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            VStack(spacing:20) {
                Spacer()
                
                VStack(spacing:0){
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
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
                .opacity(isAnimating ? 1 : 0)
                .offset(y:isAnimating ? 0 : -40)
                .animation(.easeIn(duration: 1), value: isAnimating)
                
                //MARK: Character
                ZStack{
                    CircleGroupView(shapeColor: .white, colorOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        withAnimation(.linear(duration: 0.5)) {
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                            
                                        }
                                    }
                                })
                                .onEnded({ _ in
                                    imageOffset = .zero
                                    withAnimation(.linear(duration: 0.5)) {
                                        indicatorOpacity = 1
                                        textTitle = "Share."
                                        
                                    }
                                })
                        )
                        .animation(.easeOut(duration: 1),value: imageOffset)
                }
                .overlay(alignment: .bottom) {
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44,weight: .ultraLight))
                        .offset(y: 20)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity)
                        .foregroundColor(.white)
                        
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
                            .frame(width: buttonOffset + 80)
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
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if(gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80){
                                        buttonOffset = gesture.translation.width
                                    }
                                })
                                .onEnded({ _ in
                                    withAnimation(Animation.easeOut(duration: 0.5)) {
                                        if(buttonOffset > buttonWidth / 2){
                                            buttonOffset = buttonWidth - 80
                                            hapticFeedback.notificationOccurred(.success)
                                            playSound(sound: "chimeup", type: "mp3")
                                            isOnboardingViewActive = false
                                        }else{
                                            hapticFeedback.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
                                    }
                                })
                            
                        ) //: DRAG GESTURE
                        
                        Spacer()
                    }
                    
                }
                .frame(width: buttonWidth,height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding()
                .opacity(isAnimating ? 1: 0)
                .offset(y:isAnimating ? 0: 40)
                .animation(.easeOut, value: isAnimating)
                
            } //: VStack
        } //: ZSTACK
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        
    }
}

#Preview {
    OnboardingView()
}
