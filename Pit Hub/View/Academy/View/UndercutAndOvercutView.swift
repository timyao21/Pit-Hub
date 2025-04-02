//
//  SwiftUIView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/31/25.
//

import SwiftUI

enum Strategy: String, CaseIterable, Identifiable {
    case undercut = "Undercut"
    case overcut = "Overcut"
    case normal = "Normal"
    
    var id: String { rawValue }
}

struct UndercutAndOvercutView: View {
    @State private var strategy: Strategy = .undercut
    @Environment(\.locale) var locale
    
    private let undercut_cn = """
Undercut（策略性提前进站）

在F1中，"undercut" 指后车（如车手A）选择比前车（如车手B）更早进站换胎，利用新轮胎的速度优势，在接下来几圈内跑出更快的单圈时间。当前车（车手B）正常进站时，后车（车手A）已通过新轮胎积累的圈速优势，在总用时上反超对手，最终在车手B出站后占据其前方位置。（关键：位置交换发生在对手进站后，而非赛道直接超车）

动画演示：
红车🔴选择提前一圈进站，利用新轮胎在出站后的出站圈（Out Lap）中跑出更快圈速，迅速拉开时间差。当蓝车🔵随后进站换胎时，红车🔴已通过轮胎优势建立足够优势，最终在蓝车🔵完成换胎出站时，红车凭借总用时反超，占据前方位置。
"""
    
    private let undercut_us = """
Undercut (Strategic Early Pit Stop)

In Formula 1, an "undercut" refers to a trailing driver (e.g., Driver A) choosing to pit earlier than the leading driver (e.g., Driver B) to change tires. By leveraging the speed advantage of fresh tires, the trailing driver achieves faster lap times in the subsequent laps. When the leading driver (Driver B) completes their regular pit stop, the trailing driver (Driver A) has already accumulated enough of a lap time advantage through the new tires to overtake the opponent in total race time, ultimately securing a position ahead after Driver B exits the pit lane. (Key: The position swap occurs after the opponent's pit stop, not through on-track overtaking.)

Animated Demonstration:
The Red Car opts to pit one lap earlier. Using fresh tires, it delivers a faster lap time during its out lap (the first full lap after exiting the pits), quickly building a time gap. By the time the Blue Car enters the pits for its tire change, the Red Car has established a sufficient advantage through tire performance. When the Blue Car completes its pit stop and rejoins the track, the Red Car has already surpassed it in total race time, securing the lead position.
"""
    
    private let overcut_cn = """
Overcut（策略性延迟进站）

在F1中，"overcut" 指后车（如车手A）选择比前车（如车手B）更晚进站换胎，利用旧轮胎在赛道条件改善（如干净空气，抓地力提升）或对手出站后遭遇慢车阻挡，通过多跑圈数积累时间优势，最终在完成换胎出站后反超前车。

动画演示：
当蓝车🔵进站换胎时，红车🔴选择延迟一圈进站，利用干净空气和赛道抓地力的提升，迅速拉开时间差。当红车🔴进站换胎时已经建立了足够优势，最终在出站后凭借总用时反超，占据前方位置。
"""
    
    private let overcut_us = """
Overcut (Strategic Delayed Pit Stop)
In Formula 1, "overcut" refers to when a trailing car (e.g., Driver A) deliberately pits later than the leading car (e.g., Driver B). By extending their stint with older tires, the trailing car leverages improved track conditions (clean air, enhanced grip) or the leading car encountering post-pit traffic interference to accumulate a time advantage through additional laps. This strategy ultimately allows the trailing car to overtake the leading car after completing its own pit stop.

Animated Demonstration:
When the blue car 🔵 pits for tires, the red car 🔴 delays its pit stop by one lap. Utilizing clean air and improved track grip, the red car rapidly extends its time gap. By the time the red car 🔴 completes its pit stop, it has built a sufficient lead through total elapsed time to emerge ahead of the blue car.
"""
    
    private let normal_cn = """
正常进站（无战术策略)

在F1中，当两车（如车手A与车手B）换胎耗时、出站后圈速完全一致时，双方的赛道位置将维持不变。此类进站通常仅服务于常规轮胎更换或规则强制要求，不涉及战术博弈。

动画演示：
假设红车🔴与蓝车🔵双方换胎耗时均为2.5秒，且出站后圈速完全相同。红车完成停站后仍落后蓝车，与进站前的相对位置完全一致。
"""
    
    private let normal_us = """
Standard Pit Stop (No Tactical Strategy Involved)

In Formula 1, when two cars (e.g., Driver A and Driver B) have identical pit stop durations and post-pit lap times, their positions on the track remain unchanged. These pit stops typically serve routine tire changes or fulfill mandatory regulations, without any tactical maneuvers involved.

Animated Demonstration:
Assume both the red car 🔴 and the blue car 🔵 have identical pit stop durations of 2.5 seconds, and their lap times after rejoining the track are exactly the same. After the red car completes its pit stop, it remains behind the blue car—exactly the same relative position as before the stop.
"""
    
    // Returns parameters for the CircularCircuitView based on the selected strategy.
    private func parameters(for strategy: Strategy) -> (redPitLap: CGFloat, redPitStopTime: CGFloat, redSpeedChangeLap: CGFloat, redSpeedNew: CGFloat, bluePitLap: CGFloat, bluePitStopTime: CGFloat, blueSpeedChangeLap: CGFloat, blueSpeedNew: CGFloat) {
        switch strategy {
        case .undercut:
            return (redPitLap: 1, redPitStopTime: 0.5, redSpeedChangeLap: 1, redSpeedNew: 1.08,
                    bluePitLap: 2, bluePitStopTime: 0.6, blueSpeedChangeLap: 2, blueSpeedNew: 1.06)
        case .overcut:
            return (redPitLap: 2, redPitStopTime: 0.5, redSpeedChangeLap: 1, redSpeedNew: 1.08,
                    bluePitLap: 1, bluePitStopTime: 0.6, blueSpeedChangeLap: 1, blueSpeedNew: 1.06)
        case .normal:
            return (redPitLap: 1, redPitStopTime: 0.5, redSpeedChangeLap: 1, redSpeedNew: 1,
                    bluePitLap: 2, bluePitStopTime: 0.5, blueSpeedChangeLap: 2, blueSpeedNew: 1)
        }
    }
    
    var body: some View {
        VStack {
            Picker("Strategy", selection: $strategy) {
                ForEach(Strategy.allCases) { strategy in
                    Text(LocalizedStringKey(strategy.rawValue))
                        .tag(strategy)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.vertical)
            
            // Update the text based on the selected strategy and current language.
            ScrollView {
                ZStack{
                    switch strategy {
                    case .undercut:
                        Text(locale.language.languageCode?.identifier == "zh" ? undercut_cn : undercut_us)
                            .id(strategy) // forces re-render on change
                    case .overcut:
                        Text(locale.language.languageCode?.identifier == "zh" ? overcut_cn : overcut_us)
                            .id(strategy)
                    case .normal:
                        Text(locale.language.languageCode?.identifier == "zh" ? normal_cn : normal_us)
                            .id(strategy)
                    }
                }
                .animation(.easeInOut, value: strategy)
                .frame(height: .infinity)
            }
            
            
            // Get the parameters based on the current strategy.
            let params = parameters(for: strategy)
            
            ZStack {
                CircularCircuitView(
                    redPitLap: params.redPitLap,
                    redPitStopTime: params.redPitStopTime,
                    redSpeedChangeLap: params.redSpeedChangeLap,
                    redSpeedNew: params.redSpeedNew,
                    bluePitLap: params.bluePitLap,
                    bluePitStopTime: params.bluePitStopTime,
                    blueSpeedChangeLap: params.blueSpeedChangeLap,
                    blueSpeedNew: params.blueSpeedNew
                )
                .id(strategy)
                .transition(.opacity)
            }
            .animation(.easeInOut, value: strategy)
            .padding(.top, 45)
        }
        .padding()
        .navigationTitle("Undercut & Overcut")
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    UndercutAndOvercutView()
}

