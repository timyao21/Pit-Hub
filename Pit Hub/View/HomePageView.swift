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
                        .padding(.leading, 20)
                    Text(S.title)
                        .foregroundColor(Color(S.pitHubIconColor))
                        .font(.system(size: 30))
                        .bold()
                    Spacer()
                    Button(action: {
                        // Add your action here
                        print("Profile Button tapped")
                    }) {
                        Image(systemName: "person")
                    }
                    .padding(.trailing, 20)
                    .font(.system(size: 25))
                    .foregroundColor(Color(S.pitHubIconColor))
                }
                
                VStack{
                    Text("阿布扎比")
                    Text("Race Time")
                    Text("Hello, F1 World! this is \(S.title)")
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
