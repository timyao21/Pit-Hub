//
//  ErrorView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/14/25.
//

import SwiftUI

struct DataErrorView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text(LocalizedStringKey(errorMessage()))
                .font(.headline)
                .fontWeight(.bold)

            Text("Data is still in the pit lane! ⏳")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .multilineTextAlignment(.center)
    }

    private func errorMessage() -> String {
        let messages = [
            "Red Flag! Red Flag! 🚩",
            "GP2 Data, GP2!",
            "Safety car! Matthew is clearing the track—we'll resume data as soon as possible.🚥",
            "🏎️ 52.4s Pit Stop! 🏁",
            "🚜 The green tractor is on its way with the data.",
        ]
        return messages.randomElement() ?? "Data is in the wind tunnel—stay tuned! 🔧"
    }
}

#Preview {
    DataErrorView()
}
