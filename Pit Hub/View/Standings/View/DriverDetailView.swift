//
//  DriverDetailView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/26/25.
//

import SwiftUI

struct DriverDetailView: View {
    let driverInfo: DriverStanding
    var year: String
    @ObservedObject var viewModel: DriverDetailViewModel
    
    init(for driver: DriverStanding, year: String) {
        self.year = year
        self.driverInfo = driver
        viewModel = DriverDetailViewModel()
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .center, spacing: 10){
                Group {
                    Text(driverInfo.driver.permanentNumber ?? "")
                    Text(driverInfo.driver.code ?? "")
                }
                .font(.custom(S.orbitron, size: 30))
                .fontWeight(.semibold)
                .foregroundColor(
                    GetConstructorColor(constructorId: driverInfo.constructors.last?.constructorId ?? "")
                        .opacity(0.8)
                )
                
                if let constructor = driverInfo.constructors.last {
                    DriverConstructorTag(constructor: constructor)
                }
                
                if let nationality = driverInfo.driver.nationality{
                    NationalityTag(nationality: nationality)
                }
                
                Spacer()
            }
            Text("\(driverInfo.driver.givenName) \(driverInfo.driver.familyName)")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Divider()
            
            HStack(spacing: 20) {
                StatView(iconName: "number.circle.fill", iconColor: Color(                    GetConstructorColor(constructorId: driverInfo.constructors.last?.constructorId ?? "")
                    .opacity(0.8)), value: driverInfo.positionText ?? "0", label: "Position")
                StatView(iconName: "star.fill", iconColor: .yellow, value: driverInfo.points, label: "Points")
                StatView(iconName: "trophy.fill", iconColor: .orange, value: driverInfo.wins, label: "Wins")
            }
            .padding(.vertical, 10)
            SeasonChartView(results1: viewModel.driverRaceResultPositionChart)
            Spacer()
        }
        .padding()
        .onAppear(){
            Task{
                await viewModel.fetchDriverResults(for: self.year, driverID: self.driverInfo.driver.driverId)
            }
        }
    }
    
    private struct NationalityTag: View {
        let nationality: String
        
        var body: some View {
            HStack(spacing: 2) {
                // Display flag emoji
                Text(CountryFlags.flag(for: nationality))
                    .font(.caption)
                
                // Display nationality text
                Text(NSLocalizedString(nationality, comment: "nationality Name"))
                    .font(.caption)
                    .foregroundColor(.white)
                    .bold()
            }
            .padding(4)
            .background(.gray.opacity(0.8))
            .cornerRadius(5)
        }
    }
    
    struct StatView: View {
        var iconName: String
        var iconColor: Color = .black
        var value: String
        var label: String
        
        var body: some View {
            HStack(alignment: .center, spacing: 8) {
                Image(systemName: iconName)
                    .font(.title)
                    .foregroundColor(iconColor)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(value)
                        .font(.title2)
                        .fontWeight(.bold)

                    
                    Text(label.uppercased())
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }

    
}

#Preview {
    DriverDetailView(for: DriverStanding.sample, year: "2024")
}
