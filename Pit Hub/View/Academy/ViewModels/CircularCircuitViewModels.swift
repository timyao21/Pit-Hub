//
//  UnderOverCutViewModels.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/30/25.
//

import Foundation

@MainActor
@Observable class CircularCircuitViewModels{
    
    
    @MainActor var progress: CGFloat = 0.0  // Overall progress (0.0 to 1.0)
    @MainActor var laps: CGFloat = 3
    @MainActor var frontOffset: CGFloat = 0.05   // 蓝车初始位置领先
    @MainActor var redSpeed: CGFloat = 1.0
    @MainActor var blueSpeed: CGFloat = 1.0
    
    // MARK: - 红车参数（执行undercut方）
    @MainActor var redPitLap: CGFloat = 1.0      // 早进站（第1圈）
    @MainActor var redPitStopTime: CGFloat = 0.5 // 相同停站时间
    @MainActor var redSpeedChangeLap: CGFloat = 1.0 // 出站后开始加速
    @MainActor var redSpeedNew: CGFloat = 1.08    // 显著提升速度（+5%）

    // MARK: - 蓝车参数（被undercut方）
    @MainActor var bluePitLap: CGFloat = 2.0     // 晚进站（第2圈）
    @MainActor var bluePitStopTime: CGFloat = 0.5
    @MainActor var blueSpeedChangeLap: CGFloat = 2.0 // 更晚开始加速
    @MainActor var blueSpeedNew: CGFloat = 1.04  // 小幅提速
    
    // MARK: - Button
    var timer: Timer? = nil
    var isRunning = false
    
    // Red Dot
    @MainActor var redLapProgress: CGFloat {
        let redAbsolute = progress * redSpeed * laps
        var effectiveRedAbsolute = redAbsolute
        
        // 进站逻辑
        if redAbsolute >= redPitLap && redAbsolute < redPitLap + redPitStopTime {
            effectiveRedAbsolute = redPitLap
        } else if redAbsolute >= redPitLap + redPitStopTime {
            effectiveRedAbsolute = redAbsolute - redPitStopTime
        }
        
        // 统一加速计算
        redSpeed = calculateSpeed(
            currentAbsolute: effectiveRedAbsolute,
            speedChangeLap: redSpeedChangeLap,
            speedNew: redSpeedNew
        )
        
        return effectiveRedAbsolute.truncatingRemainder(dividingBy: 1)
    }

    // Blue Dot
    @MainActor var blueLapProgress: CGFloat {
        let blueAbsolute = (progress * blueSpeed * laps) + frontOffset
        var effectiveBlueAbsolute = blueAbsolute
        
        // 进站逻辑
        if blueAbsolute >= bluePitLap && blueAbsolute < bluePitLap + bluePitStopTime {
            effectiveBlueAbsolute = bluePitLap
        } else if blueAbsolute >= bluePitLap + bluePitStopTime {
            effectiveBlueAbsolute = blueAbsolute - bluePitStopTime
        }
        
        // 统一加速计算
        blueSpeed = calculateSpeed(
            currentAbsolute: effectiveBlueAbsolute,
            speedChangeLap: blueSpeedChangeLap,
            speedNew: blueSpeedNew
        )
        
        return effectiveBlueAbsolute.truncatingRemainder(dividingBy: 1)
    }
    
    @MainActor
    private func calculateSpeed(currentAbsolute: CGFloat,
                               speedChangeLap: CGFloat,
                               speedNew: CGFloat) -> CGFloat {
        let accelerationStart = speedChangeLap
        let accelerationDuration: CGFloat = 0.7 // 统一加速时长
        let accelerationEnd = accelerationStart + accelerationDuration
        
        guard currentAbsolute >= accelerationStart else { return 1.0 }
        
        if currentAbsolute <= accelerationEnd {
            let t = (currentAbsolute - accelerationStart) / accelerationDuration
            let easedT = 1 - pow(1 - t, 3) // 统一使用easeOut缓动
            return 1.0 + (speedNew - 1.0) * easedT
        }
        return speedNew
    }
    
    
    func racetrackPointForLapProgress(_ lapProgress: CGFloat) -> CGPoint {
        let r: CGFloat = 75
        let L1: CGFloat = 150                // Top straight
        let L2: CGFloat = .pi * r            // Right arc
        let L3: CGFloat = 150                // Bottom straight
        let L4: CGFloat = .pi * r            // Left arc
        let totalLength = L1 + L2 + L3 + L4    // Total perimeter
        let s = lapProgress * totalLength
        
        if s <= L1 {
            let x = 75 + s
            return CGPoint(x: x, y: 0)
        } else if s <= L1 + L2 {
            let u = (s - L1) / L2
            let startAngle = -CGFloat.pi / 2
            let angle = startAngle + u * CGFloat.pi
            let x = 225 + r * cos(angle)
            let y = 75 + r * sin(angle)
            return CGPoint(x: x, y: y)
        } else if s <= L1 + L2 + L3 {
            let u = (s - (L1 + L2)) / L3
            let x = 225 - u * 150
            return CGPoint(x: x, y: 150)
        } else {
            let u = (s - (L1 + L2 + L3)) / L4
            let startAngle = CGFloat.pi / 2
            let angle = startAngle + u * CGFloat.pi
            let x = 75 + r * cos(angle)
            let y = 75 + r * sin(angle)
            return CGPoint(x: x, y: y)
        }
    }
    
    // Starts a timer that increments the overall progress from 0 to 1.
    @MainActor
    func startTimer() {
        isRunning = true
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true) { [weak self] _ in
            Task{ @MainActor in
                guard let self else { return }
                if self.progress >= 1 {
                    self.stopTimer()
                } else {
                    self.progress += 0.0001
                }
            }
        }
    }
    
    @MainActor
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }
}
