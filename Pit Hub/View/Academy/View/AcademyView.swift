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
                
                NavigationLink(destination: CircularCircuitView()) {
                    AcademyViewRowView()
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
    let title: LocalizedStringResource = "Academy title"
    var body: some View {
        HStack{
            Image(icon)
                .resizable()
                .frame(width: 50, height: 50)
            Text(title)
                .font(.title3)
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
