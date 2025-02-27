//
//  DriverConstructorTag.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/23/25.
//
import SwiftUI

struct DriverConstructorTag: View {
    let constructor: Constructor
    
    var body: some View {
        Text(NSLocalizedString(constructor.name, comment: "Constructor Name"))
            .font(.caption)
            .foregroundStyle(.white)
            .bold()
            .padding(4)
            .background(
                GetConstructorColor(constructorId: constructor.constructorId ?? "")
                    .opacity(0.8)
            )
            .cornerRadius(5)
    }
    
}

// Helper function to get color or default to black
func GetConstructorColor(constructorId: String) -> Color {
    if let uiColor = UIColor(named: constructorId) {
        return Color(uiColor)
    } else {
        return Color.black
    }
}
