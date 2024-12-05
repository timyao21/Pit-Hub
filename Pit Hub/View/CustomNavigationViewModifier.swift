//
//  CustomNavigationViewModifier.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/4/24.
//

import Foundation
import SwiftUI

struct CustomNavigationViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomBackButton()
                }
            }
    }
}

extension View {
    func withCustomNavigation() -> some View {
        self.modifier(CustomNavigationViewModifier())
    }
}
