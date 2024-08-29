//
//  CircleGroupView.swift
//  Restart App
//
//  Created by Oğuz Kurtoğlu on 29.08.2024.
//

import SwiftUI

struct CircleGroupView: View {
    @State var shapeColor: Color
    @State var colorOpacity: Double
    @State var isAnimating: Bool = false


    var body: some View {
        ZStack{
            Circle()
                .stroke(shapeColor.opacity(colorOpacity),lineWidth: 40)
                .frame(width: 260, height: 260,alignment: .center)
            Circle()
                .stroke(shapeColor.opacity(colorOpacity),lineWidth: 80)
                .frame(width: 260, height: 260,alignment: .center)
            
        } //: ZStack
        .blur(radius: isAnimating ? 0 : 10)
        .opacity(isAnimating ? 1 : 0)
        .scaleEffect(isAnimating ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isAnimating)
        .onAppear(perform: {
            isAnimating = true
        })
    }
}

#Preview {
    ZStack {
        Color.blue
            .ignoresSafeArea()
        CircleGroupView(shapeColor: .white, colorOpacity: 0.2)
    }
}
