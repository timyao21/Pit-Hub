//
//  SprintBadge.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/9/25.
//
import SwiftUI

struct SprintBadge: View {
    var body: some View {
        Text(LocalizedStringKey("SPRINT"))
            .font(.caption)
            .bold()
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(Color.red.opacity(0.8)) // Sprint Badge Color
            .foregroundColor(.white)
            .cornerRadius(6)
    }
}
