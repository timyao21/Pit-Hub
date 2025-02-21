//
//  SeasonProgressView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/20/25.
//

import SwiftUI

struct SeasonProgressView: View {
    let totalGP: Int
    let pastGP: Int
    @State private var animatedProgress: CGFloat = 0
    
    private var progress: CGFloat {
        totalGP > 0 ? CGFloat(pastGP) / CGFloat(totalGP) : 0
    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 20)
                    .frame(width: 125, height: 125)
                
                Circle()
                    .trim(from: 0, to: animatedProgress)
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(width: 125, height: 125)
                    .animation(.easeOut(duration: 1.0), value: animatedProgress)
                
                VStack {
                    Text("\(pastGP)/\(totalGP)")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("GP Completed")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .frame(width: 150, height: 150)
        .onAppear {
            animatedProgress = progress
        }
    }
}

#Preview {
    SeasonProgressView(totalGP: 24, pastGP: 5)
}
