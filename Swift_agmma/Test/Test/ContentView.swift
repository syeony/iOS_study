//
//  ContentView.swift
//  Test
//
//  Created by ohseungyeon on 8/3/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Circle()
                .foregroundStyle(.mint)
                .frame(width: 200, height: 200)
            Capsule()
                .foregroundStyle(.teal)
                .frame(width: 180, height: 60)
            Rectangle()
                .frame(width: 60, height: 180)
                .foregroundStyle(.indigo)
            Circle()
                .foregroundStyle(.pink)
                .frame(width: 100, height: 100)
            Circle()
                .foregroundStyle(.white)
                .frame(width: 40, height: 40)
        }
    }
}

#Preview {
    ContentView()
}
