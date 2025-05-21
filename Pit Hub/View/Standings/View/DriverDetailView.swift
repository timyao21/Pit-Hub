//
//  DriverDetailView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/26/25.
//
import SwiftUI


struct DriverDetailView: View {
    //    view model
    @State var viewModel = ViewModel()
    @State private var path: [String] = []
    
    let driverInfo: DriverStanding
    let year: String
    
    init(for driver: DriverStanding, year: String) {
        self.year = year
        self.driverInfo = driver
    }
    
    var composedName: Text {
        Text(LocalizedStringKey(driverInfo.driver.givenName)) +
        Text(LocalizedStringKey("·\u{200B}")) +
        Text(LocalizedStringKey(driverInfo.driver.familyName))
    }
    
    var body: some View {
        VStack(alignment: .leading){
            headerSection
            composedName
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Divider()
            
            statsSection
                .padding(.vertical, 10)
            
            chartSection
            
            Spacer()
        }
        .padding()
        .onAppear(){
            Task{
                await viewModel.fetchDriverResults(for: self.year, driverID: self.driverInfo.driver.driverId)
            }
        }
        .navigationTitle(driverInfo.driver.code ?? "")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                NavigationLink{
                    SeasonPositionChartView(results1: viewModel.driverRaceResultPositionChart)
                } label: {
                    Text(LocalizedStringResource("Comparison"))
                }
            }
        }
    }
    // MARK: - Driver detial Header
    private var headerSection: some View {
        HStack(alignment: .center, spacing: 10){
            Group {
                Text(driverInfo.driver.permanentNumber ?? "")
                Text(driverInfo.driver.code ?? "")
            }
            .font(.custom(S.orbitron, size: 30))
            .fontWeight(.semibold)
            .foregroundColor(
                Color.constructorColor(for: driverInfo.constructors.last?.constructorId ?? "")
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
    }
    
    // MARK: - Stats Section
    private var statsSection: some View {
        HStack(spacing: 20) {
            StatView(iconName: "number.circle.fill", iconColor: Color.constructorColor(for: driverInfo.constructors.last?.constructorId ?? "").opacity(0.8), value: driverInfo.positionText ?? "0", label: "Position")
            StatView(iconName: "star.fill", iconColor: .yellow, value: driverInfo.points, label: "Points")
            StatView(iconName: "trophy.fill", iconColor: .orange, value: driverInfo.wins, label: "Wins")
        }
    }
    
    // MARK: - Chart
    private var chartSection: some View {
        Group{
            if viewModel.driverRaceResultPositionChart.isEmpty {
                LoadingOverlay()
                    .frame(height: 300)
                    .cornerRadius(20)
            }else{
                SeasonPositionChartView(results1: viewModel.driverRaceResultPositionChart)
            }
        }
    }
    
    // MARK: - Driver Compare
    private var driverCompareChart: some View{
        NavigationLink(destination: SeasonPositionChartView(results1: viewModel.driverRaceResultPositionChart)) {
            HStack{
                Image(systemName: "chart.bar.doc.horizontal")
                    .font(.headline)
//                    .foregroundColor(.accentColor)
                Text("Driver Comparison")
                    .fontWeight(.medium)
//                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "chevron.right")
//                    .foregroundColor(.secondary)
            }
            .padding(5)
            .foregroundColor(Color(S.pitHubIconColor))
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(S.pitHubIconColor), lineWidth: 1)
            )
        }
    }
    
    // MARK: - NationalityTag
    private struct NationalityTag: View {
        let nationality: String
        
        var body: some View {
            HStack(spacing: 2) {
                // Display flag emoji
                Text(CountryFlags.flag(for: nationality))
                    .font(.caption)
                
                // Display nationality text
                Text(LocalizedStringKey(nationality))
                    .font(.caption)
                    .foregroundColor(.white)
                    .bold()
            }
            .padding(4)
            .background(.gray.opacity(0.8))
            .cornerRadius(5)
        }
    }
    
    // MARK: - StatView
    private struct StatView: View {
        var iconName: String
        var iconColor: Color = .black
        var value: String
        var label: LocalizedStringKey
        
        var body: some View {
            HStack(alignment: .center, spacing: 8) {
                Image(systemName: iconName)
                    .font(.title)
                    .foregroundColor(iconColor)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(value)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    
                    Text(label)
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
