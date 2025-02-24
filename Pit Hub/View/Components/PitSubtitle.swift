//
//  PitSubtitle.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/22/25.
//

import SwiftUI

struct PitSubtitle: View {
    let title: String
    init(for title: String) {
        self.title = title
    }
    var body: some View {
        Text(NSLocalizedString("\(title)", comment: "For PitSubtitle"))
            .font(.custom(S.smileySans, size: 20))
            .foregroundColor(Color(S.pitHubIconColor))
    }
}
