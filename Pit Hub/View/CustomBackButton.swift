//
//  CustomBackButton.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/4/24.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrowshape.backward.fill")
                .foregroundColor(Color(S.pitHubIconColor))
        }
    }
}
