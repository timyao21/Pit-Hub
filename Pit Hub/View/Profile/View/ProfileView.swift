//
//  ProfileView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/29/24.
//

import SwiftUI

struct ProfileView: View {
    
    @Environment(\.colorScheme) private var scheme
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    //    for Silding effect
    @Namespace private var animation
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Pit House - P房")
                    .font(.custom(S.smileySans, size: 20))
                    .padding(.top, 20)
                Form{
                    Section(header: Text("车队")){
                        NavigationLink(destination: Text("Destination")) {
                            Text("我")
                        }
                        NavigationLink(destination: Text("Destination")) {
                            Text("车手")
                        }
                        NavigationLink(destination: Text("Destination")) {
                            Text("车队")
                        }
                    }
                    .font(.custom(S.smileySans, size: 20))
                    
                    Section(header: Text("涂装")){
                        HStack(spacing: 0){
                            ForEach(Theme.allCases, id: \.rawValue){ theme in
                                Text(theme.rawValue)
                                    .padding(.vertical, 10)
                                    .frame(width: 100)
                                    .background{
                                        ZStack{
                                            if userTheme == theme {
                                                Capsule()
                                                    .fill(Color(S.pitHubIconColor))
                                                    .matchedGeometryEffect(id: "ActiveTab", in: animation)
                                            }
                                        }
                                        .animation(.snappy, value: userTheme)
                                    }
                                    .contentShape(.rect)
                                    .onTapGesture {
                                        userTheme = theme
                                        print(theme)
                                    }
                            }
                        }
                        .padding(3)
                        .background(.primary.opacity(0.06), in: .capsule)
                    }
                    .font(.custom(S.smileySans, size: 20))
                }
            }
        }
        .preferredColorScheme(userTheme.colorScheme(for: scheme))
    }
}

#Preview {
    ProfileView()
}

enum Theme: String, CaseIterable {
    case systemDefault = "Default"
    case light = "Light"
    case dark = "Dark"
    
    // Returns the color scheme based on the selected theme
    func colorScheme(for currentScheme: ColorScheme) -> ColorScheme? {
        switch self {
        case .systemDefault:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
}
