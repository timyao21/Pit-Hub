//
//  AcademyView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/31/25.
//

import SwiftUI

struct AcademyView: View {
    @Environment(IndexViewModel.self) var viewModel
    @Environment(\.locale) var locale
    var curLanguage: String {
        locale.language.languageCode?.identifier ?? "en"
    }
    
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
                NavigationLink(destination: NewUnercutAndOvercutView()) {
                    if curLanguage == "zh"{
                        AcademyViewRowView(icon: "\(S.pitIcon)", title:"Undercut and Overcut", subtitle:"Race Strategy", subtitleCN: "- Commonly Called: Swap Out")
                    }else{
                        AcademyViewRowView(icon: "BlueFlag", title:"Undercut and Overcut", subtitle:"Race Strategy")
                    }
                }
                Divider()
                NavigationLink(destination: NewRaceFlag()) {
                    AcademyViewRowView(icon: "Checked flag", title:"F1 Race Flag Signals", subtitle:"Race Regulations")
                }
            }
            Spacer()
        }
        .padding()
    }
}

private struct AcademyViewRowView: View {
    let icon: String
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey
    let subtitleCN: LocalizedStringKey

    init() {
        self.icon = "\(S.pitIcon)"
        self.title = LocalizedStringKey("Academy title")
        self.subtitle = LocalizedStringKey("Academy subtitle")
        self.subtitleCN = LocalizedStringKey("")
    }
    

    init(icon: String, title: String, subtitle: String) {
        self.icon = icon
        self.title = LocalizedStringKey(title)
        self.subtitle = LocalizedStringKey(subtitle)
        self.subtitleCN = LocalizedStringKey("")
    }
    
    init(icon: String, title: String, subtitle: String, subtitleCN: String) {
        self.icon = icon
        self.title = LocalizedStringKey(title)
        self.subtitle = LocalizedStringKey(subtitle)
        self.subtitleCN = LocalizedStringKey(subtitleCN)
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
                HStack {
                    Text(subtitle)
                    Text(subtitleCN)
                }
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
