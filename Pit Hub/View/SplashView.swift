//
//  SplashView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/2/24.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
    @State private var currentTime: String = ""
    
    var body: some View {
        
        if self.isActive{
            BottomNavBar()
        }else{
            ZStack{
                Rectangle()
                    .fill(Color(S.primaryBackground))
                    .ignoresSafeArea()
                HStack{
                    Image("PitIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    Text("Pit Hub")
                        .font(.custom(S.orbitron, size: 40))
                        .foregroundColor(Color(S.pitHubIconColor))
                        .bold()
                }
            }
            .onAppear(){
                print(DateUtils.getCurrentDate())
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
