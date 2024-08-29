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

    var body: some View {
        ZStack{
            Circle()
                .stroke(shapeColor.opacity(colorOpacity),lineWidth: 40)
                .frame(width: 260, height: 260,alignment: .center)
            Circle()
                .stroke(shapeColor.opacity(colorOpacity),lineWidth: 80)
                .frame(width: 260, height: 260,alignment: .center)
            
        }   
    }
}

#Preview {
    ZStack {
        Color.blue
            .ignoresSafeArea()
        CircleGroupView(shapeColor: .white, colorOpacity: 0.2)
    }
}
