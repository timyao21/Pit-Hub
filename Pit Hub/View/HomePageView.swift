//
//  HomePageView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/2/24.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        ZStack{
            VStack{
                HStack(){
                    Image(S.pitIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                    Text(S.title)
                        .foregroundColor(Color(S.pitHubIconColor))
                        .font(.system(size: 30))
                        .bold()
                }
                Spacer()
                Text("Hello, F1 World! this is \(S.title)")
                Spacer()
            }
        }
    }
}

#Preview {
    HomePageView()
}
