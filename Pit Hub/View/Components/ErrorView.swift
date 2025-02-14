//
//  ErrorView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/14/25.
//

import SwiftUI


struct ErrorView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("🚨 Box! Box! Box! 🚨")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.red)

            Text("We've hit a mechanical issue—time for a pit stop! 🏎️🔧")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)

            Text("Hold tight, the crew is on it! 🛠️⏳")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .multilineTextAlignment(.center)
    }
}

#Preview {
    ErrorView()
}
