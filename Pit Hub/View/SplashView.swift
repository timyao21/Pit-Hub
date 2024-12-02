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
            HomePageView()
        }else{
            ZStack{
                Rectangle()
                    .fill(Color(hex: 0x1C1C1C))
                    .ignoresSafeArea()
                HStack{
                    Image("PitIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    Text("Pit Hub")
                        .font(.system(size: 50))
                        .font(.title)
                        .foregroundColor(Color(hex: 0xef5c23))
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


extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}
