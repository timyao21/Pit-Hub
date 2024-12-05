//
//  SplashView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/2/24.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
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
                        .font(.system(size: 50))
                        .font(.title)
                        .foregroundColor(Color(S.pitHubIconColor))
                        .bold()
                }
            }
            .onAppear(){
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
