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
            Text("🏎️ Overtake Denied! 🏁")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.red)

            Text(errorMessage())
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)

            Text("Refresh or check back later! 🔄")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .multilineTextAlignment(.center)
    }

    private func errorMessage() -> String {
        let messages = [
            "Data is still in the pit lane—hold tight! ⏳",
            "We’re stuck in a red flag situation—stay tuned! 🚩",
            "Telemetry isn’t coming through—engineers are on it! 🔧",
            "Looks like we’re under Safety Car—data coming soon! 🚥",
            "Fasten your seatbelt, the numbers are catching up! 🏎️"
        ]
        return messages.randomElement() ?? "Data is in the wind tunnel—stay tuned! 🔧"
    }
}

struct RaceResultUpdateErrorView: View {
    var body: some View {
        VStack{
            Text("Race is still going on!")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
    }
}
#Preview {
    DataErrorView()
}
