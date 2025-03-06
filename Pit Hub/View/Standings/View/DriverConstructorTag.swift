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
        Text(LocalizedStringKey(constructor.name))
            .font(.caption)
            .foregroundStyle(.white)
            .bold()
            .padding(4)
            .background(
                Color.constructorColor(for: constructor.constructorId)
            )
            .cornerRadius(5)
    }
    
}

// Helper function to get color or default to black
//func GetConstructorColor(constructorId: String) -> Color {
//    if let uiColor = UIColor(named: constructorId) {
//        return Color(uiColor)
//    } else {
//        return Color.black
//    }
//}
extension Color {
    static func constructorColor(for constructorId: String?) -> Color {
        guard let id = constructorId, !id.isEmpty, let uiColor = UIColor(named: id) else {
            return .black
        }
        return Color(uiColor)
    }
}
