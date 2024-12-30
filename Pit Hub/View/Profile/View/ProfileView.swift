//
//  ProfileView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/29/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack{
                Text("Pit House - P房")
                    .font(.custom(S.smileySans, size: 20))
                Form{
                    Section(header: Text("车手")){
                        NavigationLink(destination: Text("Destination")) {
                            Text("账号")
                        }
                    }.font(.custom(S.smileySans, size: 20))
                    
                    Section(header: Text("外观")){
                        Toggle(isOn: .constant(true), label: { Text("深色")})
                        Toggle(isOn: .constant(true), label: { Text("主题")})
                    }.font(.custom(S.smileySans, size: 20))
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
