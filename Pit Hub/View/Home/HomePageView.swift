// MARK: - Lifecycle Methods
//  HomePageView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/2/24.
//

import SwiftUI

struct HomePageView: View {
    @State private var currentDeviceDate = Date()
    @State private var qualiLocalDateString = ""
    @State private var raceLocalDateString = ""
    
    @State private var curGpQ = GrandPrix()
    @State private var curGpR = GrandPrix()
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(Color(S.primaryBackground))
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Image(S.pitIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                        Text(S.title)
                            .foregroundColor(Color(S.pitHubIconColor))
                            .font(.system(size: 30))
                            .bold()
                        Spacer()
                        NavigationLink(destination: LoginView()) {
                            Text("登录")
                                .bold()
                        }
                        .font(.system(size: 15))
                        .foregroundColor(Color(S.pitHubIconColor))
                    }
                    .padding()
                    VStack (alignment: .leading) {
                        HStack{
                            VStack (alignment: .leading) {
                                Text("\(curGpQ.country_code)")
                                    .font(.system(size: 20))
                                Text("\(curGpQ.circuit_short_name)")
                                    .font(.system(size: 28))
                            }
                            Spacer()
                            Image(S.pitIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                        }
                        Text("排位: \(qualiLocalDateString)")
                            .font(.system(size: 15))
                        Text("正赛: \(raceLocalDateString)")
                            .font(.system(size: 15))
                    }
                    .padding()
                    Spacer()
                    Text("Hello, F1 World! this is \(S.title)")
                    Spacer()
                }
            }
        }
        .onAppear {
            getGrandPrix(year: 2024, country_code: "BEL") { grandPrix in
                if let grandPrix = grandPrix {
                    DispatchQueue.main.async {
                        self.curGpQ = grandPrix[0]
                        self.curGpR = grandPrix[1]
                        qualiLocalDateString = updateLocalData(dataString: curGpQ.date_start)
                        raceLocalDateString = updateLocalData(dataString: curGpR.date_start)
                        print("updated")
                    }
                } else {
                    print("Failed to fetch GrandPrix!")
                }
            }
        }
    }
}

// MARK:  getGrandPrix
func updateLocalData(dataString : String) -> String {
    let timeModel = TimeModel(isoDateString: dataString)
    if let localDate = timeModel.toLocalTime() {
        return localDate
    } else {
        return "Date conversion failed for: \(dataString)"
    }
}
    



// MARK:  preview

#Preview {
    HomePageView()
}
