//
//  ContentView.swift
//  Pinch
//
//  Created by Oğuz Kurtoğlu on 29.08.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    
    func resetImageState() {
        withAnimation(.spring) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.clear
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(imageOffset)
                    .scaleEffect(imageScale)
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1{
                            withAnimation(.spring) {
                                imageScale = 5
                            }
                        }else{
                            resetImageState()
                        }
                    })
                    .gesture(
                        DragGesture()
                            .onChanged({ gesture in
                                withAnimation(.linear) {
                                    imageOffset = gesture.translation
                                }
                            })
                            .onEnded({ _ in
                                if imageScale <= 1{
                                    resetImageState()
                                }
                            })
                    )
                    // MARK: - 3. MAGNIFICATION
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                withAnimation(.linear(duration: 1)) {
                                    if imageScale >= 1 && imageScale <= 5 {
                                        imageScale = value
                                    } else if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            }
                            .onEnded { _ in
                                if imageScale > 5 {
                                    imageScale = 5
                                } else if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                    )
            }
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            })
            
            // MARK: - INFO PANEL
            .overlay(
              InfoPanelView(scale: imageScale, offset: imageOffset)
                .padding(.horizontal)
                .padding(.top, 30)
              , alignment: .top
            )
            // MARK: - CONTROLS
            .overlay(
              Group {
                HStack {
                  // SCALE DOWN
                  Button {
                    withAnimation(.spring()) {
                      if imageScale > 1 {
                        imageScale -= 1
                        
                        if imageScale <= 1 {
                          resetImageState()
                        }
                      }
                    }
                  } label: {
                    ControlImageView(icon: "minus.magnifyingglass")
                  }
                  
                  // RESET
                  Button {
                    resetImageState()
                  } label: {
                    ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                  }
                  
                  // SCALE UP
                  Button {
                    withAnimation(.spring()) {
                      if imageScale < 5 {
                        imageScale += 1
                        
                        if imageScale > 5 {
                          imageScale = 5
                        }
                      }
                    }
                  } label: {
                    ControlImageView(icon: "plus.magnifyingglass")
                  }
                  
                } //: CONTROLS
                .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .opacity(isAnimating ? 1 : 0)
              }
                .padding(.bottom, 30)
              , alignment: .bottom
            )        } //: NAVIGATIONVIEW
        
        
 
        .navigationViewStyle(.stack)
    }
    
}

#Preview {
    ContentView()
}
