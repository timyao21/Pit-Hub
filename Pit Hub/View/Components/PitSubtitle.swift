//
//  PitSubtitle.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/22/25.
//

import SwiftUI

struct PitSubtitle: View {
    let title: LocalizedStringKey
    
    init(for title: LocalizedStringKey) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(.custom(S.smileySans, size: 20))
            .foregroundColor(Color(S.pitHubIconColor))
    }
}
