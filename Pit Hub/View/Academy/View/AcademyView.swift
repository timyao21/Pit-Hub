//
//  AcademyView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/31/25.
//

import SwiftUI

struct AcademyView: View {
    @Environment(IndexViewModel.self) var viewModel
    var body: some View {
        VStack{
            HStack {
                Image(S.pitIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                Spacer()
            }
            
            NavigationStack {
                
                NavigationLink(destination: UndercutAndOvercutView()) {
                    AcademyViewRowView(title:"Undercut and Overcut", subtitle:"Race strategy")
                }
                Divider()
                NavigationLink(destination: CircularCircuitView()) {
                    AcademyViewRowView()
                }
            }
            Spacer()
        }
        .padding()
    }
}

private struct AcademyViewRowView: View {
    let icon: String = "\(S.pitIcon)"
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey

    init() {
        self.title = LocalizedStringKey("Academy title")
        self.subtitle = LocalizedStringKey("Academy subtitle")
    }
    

    init(title: String, subtitle: String) {
        self.title = LocalizedStringKey(title)
        self.subtitle = LocalizedStringKey(subtitle)
    }
    
    var body: some View {
        HStack{
            Image(icon)
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading){
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                Text(subtitle)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .imageScale(.small)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
}

#Preview {
    BottomNavBarIndexView()
}
