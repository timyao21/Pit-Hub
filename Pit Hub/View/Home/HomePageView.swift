// MARK: - Lifecycle Methods
//  HomePageView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/2/24.
//

import SwiftUI

struct HomePageView: View {
    @State private var currentTime: Date = Date()
    @State private var qualiLocalDateString = ""
    @State private var raceLocalDateString = ""
        
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(Color(S.primaryBackground))
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Image(S.pitIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                        Text(S.title)
                            .foregroundColor(Color(S.pitHubIconColor))
                            .font(.system(size: 30))
                            .bold()
                        Spacer()
                        NavigationLink(destination: LoginView()) {
                            Text("登录")
                                .font(.custom(S.smileySans, size: 17))
                        }
                        .font(.system(size: 15))
                        .foregroundColor(Color(S.pitHubIconColor))
                    }
                    .padding()
                    Spacer()
                    Text("Hello, F1 World! this is \(S.title)")
                    Spacer()
                }
            }
        }
    }
}

    



// MARK:  Preview
#Preview {
    HomePageView()
}
