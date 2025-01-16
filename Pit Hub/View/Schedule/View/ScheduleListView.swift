//
//  ScheduleList.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/12/24.
//

import SwiftUI

struct ScheduleListView: View {
    
    @State private var selectedTab = 2
    @StateObject var viewModel = ViewModel()
    
    // MARK: - UI
    var body: some View {
        NavigationSplitView{
            VStack{
                HStack(spacing: 0){
                    Text(String(viewModel.curYear))
                    Menu {
                        let now = Calendar.current.component(.year, from: Date())
                        ForEach(2023...now, id: \.self) { year in
                            Button(action: {
                                viewModel.changeYear(year: year)
                            }) {
                                Text(String(year)) // Year options
                            }
                        }
                    } label: {
                        HStack {
                            Text("年F1赛程表")
                            Image(systemName: "chevron.down") // Dropdown arrow
                        }
                    }
                }
                .font(.custom(S.smileySans, size: 30))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color(S.pitHubIconColor)) // Change the title color here
                .padding(.horizontal, 16)
                
                
                
                TabView(selection: $selectedTab){
                    
                        if !viewModel.pastMeetings.isEmpty {
                            VStack{
                                
                                SectionHeader(title: "已结束...")
                                ScrollView {
                                    ForEach(viewModel.pastMeetings.reversed()) { meeting in
                                        NavigationLink {
                                            ScheduleDetailView(meeting: meeting)
                                        } label: {
                                            ScheduleRow(meeting: meeting)
                                                .padding(.vertical, 5)
                                        }
                                        .padding(.horizontal, 16)
                                        .cornerRadius(8)
                                        .padding(.vertical, 6)
                                        .tint(.primary) // Prevent the blue tint
                                    }
                                }
                            }.tag(1)
                        }
                        
                        if !viewModel.upcomingMeetings.isEmpty {
                            VStack{
                                ProgressBar(curYear: viewModel.curYear, total: viewModel.meetings.count, curRace: viewModel.pastMeetings.count)
                                SectionHeader(title: "接下来...")
                                ScrollView {
                                    ForEach(viewModel.upcomingMeetings) { meeting in
                                        NavigationLink {
                                            ScheduleDetailView(meeting: meeting)
                                        } label: {
                                            ScheduleRow(meeting: meeting)
                                                .padding(.vertical, 5)
                                        }
                                        .padding(.horizontal, 16)
                                        .cornerRadius(8)
                                        .padding(.vertical, 6)
                                        .tint(.primary) // Prevent the blue tint
                                    }
                                }
                            }.tag(2)
                        }
                    // Fallback UI for Empty Lists
                    if viewModel.upcomingMeetings.isEmpty && viewModel.pastMeetings.isEmpty {
                        HStack {
                            Text("Sry, 暂无\(String(viewModel.curYear))数据")
                            Image(systemName: "exclamationmark.icloud")
                        }
                        .font(.custom(S.smileySans, size: 30))
                        .tag(3) // Add a unique tag for the fallback
                    }
                }
                .tabViewStyle(.page)
                
            }
            .background(Color(S.primaryBackground))
        } detail: {
            Text("Select a Schedule")
        }
        .onAppear {
            viewModel.fetchMeetings()
        }
    }
}

// MARK: - Section Header Text Style
struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.custom(S.smileySans, size: 25))
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(Color(S.pitHubIconColor)) // Change the title color here
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
    }
}

// MARK: - Progressbar
struct ProgressBar: View {
    var curYear: Int
    var total: Int
    var curRace: Int
    var progress: CGFloat {
        guard total > 0 else { return 0 } // Avoid division by zero
        return CGFloat(curRace) / CGFloat(total)
    }
    var width: CGFloat = 300
    var height: CGFloat = 12
    var CRadius: CGFloat = 10
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7){
            HStack{
                Text("已完成 \(String(curRace)) / \(String(total))").bold().font(.callout)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(S.pitHubIconColor),Color.yellow]), startPoint: .leading, endPoint: .trailing))
                Spacer()
                Group{
                    Image(systemName: "flag.pattern.checkered")
                    Text("2025赛季")
                }
                .font(.caption)
                .foregroundStyle(.gray.opacity(0.9))
            }
            .frame(width: width)
            
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: CRadius)
                    .frame(width: width, height: height)
                    .foregroundStyle(.gray.opacity(0.3))
                    .shadow(radius: 10)
                RoundedRectangle(cornerRadius: CRadius)
                    .frame(width: progress * width, height: height)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(S.pitHubIconColor),Color.yellow]), startPoint: .leading, endPoint: .trailing))
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ScheduleListView()
}
