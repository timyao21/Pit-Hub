//
//  NewRaceFlag.swift
//  Pit Hub
//
//  Created by Junyu Yao on 4/6/25.
//

import SwiftUI

struct NewRaceFlag: View {
    
    @State private var selectedTab: Int = 0
    
    private let tabs = ["Blue flag", "Red flag", "Yellow flag", "Green flag", "Black flag", "Black And White flag", "Black flag with an orange disc"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            HStack(alignment: .bottom){
                Image(systemName: "chevron.left.chevron.left.dotted")
                    .foregroundColor(Color(S.pitHubIconColor))
                    .frame(height: 25)
                SubTabSelector(selectedTab: $selectedTab, tabTitles: tabs)
                Image(systemName: "chevron.right.dotted.chevron.right")
                    .foregroundColor(Color(S.pitHubIconColor))
                    .frame(height: 25)
            }
            .padding()
            
            TabView(selection: $selectedTab){
                ForEach(tabs.indices) { index in
                    RaceFlagSubview(title: tabs[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page)
        }
        .navigationTitle(Text("F1 Race Flag Signals"))
        .toolbar(.hidden, for: .tabBar)
    }
}


private struct RaceFlagSubview: View {
    @Environment(\.locale) var locale
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    var flagDescriptionUS: String {
        switch title {
            // Blue Flag
        case "Blue flag":
            return """
The blue flag is primarily used to signal to a driver that they are about to be overtaken, though its interpretation shifts slightly depending on the session:
            
At all times:

It is displayed to drivers exiting the pit lane, warning them that traffic is approaching from behind and advising extra caution when rejoining the circuit.

During practice:

It indicates that a faster car is immediately behind and poised to overtake. For instance, a driver on a 'cool-down' lap might receive the blue flag while a competitor is on a much quicker lap, such as during a qualifying simulation.

During the race:

The blue flag is shown to a driver who is about to be lapped (i.e., when faster cars catch up and the driver falls a full lap behind). When signaled, the driver must let the following car pass at the earliest opportunity. Ignoring three warnings will result in a penalty.
"""
            //Red flag
        case "Red flag":
            return """
The red flag is displayed at the start line and across all marshal posts around the circuit when officials deem it necessary to halt a session or race. This decision may stem from critical incidents, hazardous track conditions, or extreme weather.

During practice sessions and qualifying:

Drivers must immediately reduce speed, cease overtaking, and proceed cautiously to their respective pit garages. 

During the race:

Drivers are similarly required to slow down, enter the pit lane in a controlled manner, and queue at the exit until further instructions are provided. The red flag ensures safety is prioritized, with all action suspended until normal conditions are restored.
"""
            // Yellow Flag
        case "Yellow flag":
            return """
        The yellow flag signifies a caution. It is displayed when there is a hazard on or near the track (e.g., an accident, debris, or a stopped vehicle).

        1. Single-Waved Yellow Flag (Single Yellow Flag):
            - Drivers must immediately reduce speed, avoid overtaking, and prepare to alter their racing line.
        
            - Drivers are required to significantly slow down in the affected section of the track.
        
        2. Double-Waved Yellow Flag (Double Yellow Flag):
            - Indicates that the track is fully or partially blocked (e.g., by obstacles or a severe incident, with a danger level between a single yellow flag and a red flag). 
            - Drivers must slow down further and be prepared to stop.
        
            - Drivers must drastically reduce speed, avoid overtaking, and be ready for emergency maneuvers (e.g., sudden lane changes or stopping).

        Special Rules (During Free Practice and Qualifying Sessions): 
        
        When a yellow flag is shown, drivers must visibly abandon their attempt to set a timed lap (i.e., they cannot pursue a valid lap time). While drivers must immediately halt their push for a fast lap, they are not required to pit (as the track may be cleared by the next lap).
        """
            // Green Flag
        case "Green flag":
            return """
        The green flag signifies that the track is clear and safe for racing.
        
        It is commonly displayed at the beginning of warm-up laps, practice sessions, or qualifying rounds, as well as immediately after an incident that necessitated yellow flags. By waving the green flag, officials communicate that normal racing conditions have resumed, allowing drivers to proceed at full speed.
        """
            // Black flag
        case "Black flag":
            return """
        The black flag is the highest-level penalty signal in Formula 1, indicating a driver’s immediate disqualification.

        The flagged driver must promptly enter the pit lane and retire from the race.

        Typical reasons for issuing a black flag:

        - Extreme dangerous conduct (e.g., intentionally colliding with other drivers)
        - Major technical violations (e.g., a car failing to meet regulatory standards and being irreparable on-site)

        Enforcement rules:

        1. The black flag is extremely rare in F1. Stewards typically only deploy it when a driver’s actions or car condition pose a critical threat to race safety.
        2. If a driver ignores the black flag (e.g., delays entering the pits), their results will be voided, and they may face additional penalties (e.g., suspension).

        Summary: The black flag represents an irreversible mandatory retirement order and is one of the most severe penalties in F1’s regulatory framework.
        """
            // Black And White flag
        case "Black And White flag":
            return """
        The diagonally divided black-and-white flag is used to warn a driver of unsportsmanlike conduct or minor rule violations.

        Similar to a "yellow card" in soccer, it does not impose an immediate penalty but serves as an official notice that their behavior has been recorded, and further infractions may lead to sanctions.

        Actions that may trigger the flag include:

        - Dangerous driving (e.g., compromising the safety of other drivers)
        - Repeatedly exceeding track limits
        - Other breaches of fair competition rules

        Enforcement protocol:

        1. Marshals display the black-and-white flag alongside the offending driver’s number board to identify the responsible party.
        2. If the driver continues the behavior after the warning, penalties may be applied, such as:
            - Time penalty
            - Drive-through penalty
            - Stop-and-go penalty

        The flag aims to maintain fairness by providing immediate warnings rather than direct punishment, while deterring further misconduct.
        """
        case "Black flag with an orange disc":
            return """
        The black flag with an orange disc (commonly nicknamed the "meatball flag") is a special signal in F1 used to alert a driver of a mechanical failure or safety hazard (e.g., loose components, fluid leaks, or critical damage).

        Enforcement rules:

        1. Marshals display this flag alongside the driver’s number board. The flagged driver must return to the pits immediately for their team to inspect and repair the issue (if repairs can be made on-site).
        2. Ignoring the flag may result in penalties, such as a black flag (mandatory disqualification).

        Purpose:

        - Forces teams to address mechanical issues promptly to prevent the car from posing risks to others.
        - Avoids accidents or track blockages caused by worsening car conditions.

        Summary: The "meatball flag" acts as a proactive safety measure, prioritizing track safety while allowing teams a chance to fix issues before penalties are applied.
        """
        default:
            return "Unknown"
        }
    }
    
    var flagDescriptionZH: String {
        switch title {
        case "Blue flag":"""
            蓝旗通常用来通知车手他们即将被超车，但在比赛中它与周末早些时候各阶段的含义略有不同：
            
            1. 任何情况下:
            - 当车手离开维修区时，蓝旗会被挥出，提醒车手注意后方来车（基本上是告知车手在重新进入赛道时要特别小心）。
            
            2. 练习赛时：
            - 蓝旗会显示给车手，提醒他们有更快的车辆紧随其后，即将超越。例如，较慢的车手可能正在进行“冷却”圈，准备返回维修区，而后面的车手则正在进行速度更快的圈速（例如排位赛模拟圈）。
            
            3. 比赛时：
            - 蓝旗会显示给即将被“套圈”的车手（即被前面更快的车辆追上，落后一整圈）。当被显示蓝旗时，相关车手必须在第一时间让后方车辆通过；如果连续三次警告无效，则将受到处罚。
            """
        case "Red flag":"""
            当赛事官员决定暂停练习赛、排位赛或正赛时（原因包括严重事故或恶劣天气等），红旗会在起跑线及赛道沿途的每个观察站同时挥动。
            
            1. 在练习赛和排位赛中:
            - 所有车手必须减速并缓慢驶回各自维修区车库。
            
            2. 正赛中:
            - 车手需减速并缓慢进入维修区通道，在出口处列队并等待进一步指令。
            """
        case "Yellow flag":"""
黄旗代表警示。当赛道上或附近出现危险（如事故、碎片、停驶车辆等）时，裁判会出示黄旗。：

1. 单次挥动黄旗（单黄旗）：
    - 车手需立即减速，禁止超车，并做好改变行驶路线的准备。

    - 车手必须在相关赛道区域明显降低车速。

2. 双挥动黄旗（双黄旗）：
    - 表示赛道被障碍物完全或部分阻挡，或比较严重的事故（严重程度介于单黄旗和红旗之间），车手必须进一步减速并做好停车准备。

    - 车手需大幅减速，禁止超车，并准备好紧急变道或停车。

特别规则（自由练习赛和排位赛期间）：

- 当黄旗出现时，车手必须明显放弃当前计时圈的尝试（即不能追求有效圈速成绩）。虽然车手需要立即终止当前圈速的冲刺，但无需强制进站（因为下一圈赛道可能已清理完毕）。

总结：黄旗等级越高（双挥动），危险程度越高，车手需采取更谨慎的应对措施，同时在竞速阶段需主动放弃受影响区域的圈速挑战。
"""
        case "Green flag":"""
            绿旗用于指示赛道已恢复畅通无阻。
            
            无论是在暖胎圈开始时、练习赛或排位赛期间，还是在需要出示一面或多面黄旗的事故发生后立即恢复比赛时，绿旗都会被挥动以传递这一关键信息。
            """
        case "Black flag":"""
            黑旗（Black Flag）是F1赛事中的最高级别处罚信号，表示车手被立即取消参赛资格。
            
            收到此旗的车手必须立刻驶入维修区并退出比赛。

            触发黑旗的典型原因：

            - 极端危险行为（如故意撞击其他车手）
            - 严重技术违规（如赛车不符合规则标准且无法现场修复）

            执行规则：

            1. 黑旗在F1中极为罕见，赛事干事通常仅在车手行为或赛车问题对比赛安全构成重大威胁时才会出示。
            2. 若车手无视黑旗（未及时进站退赛），其后续成绩将作废，并可能面临追加处罚（如禁赛）。

            黑旗代表比赛中不可逆的强制退赛命令，是F1规则体系中最严厉的处罚手段之一。
            """
        case "Black And White flag":"""
            黑白旗（对角黑白方格旗）用于警告车手存在违反体育道德的行为或轻微违规。
            其作用类似于足球中的“黄牌”——虽不立即处罚，但明确告知车手其行为已被记录，若继续违规将面临惩罚。
            
            可能触发黑白旗的行为包括：

            - 危险驾驶（如危及其他车手安全）
            - 频繁超出赛道限制
            - 其他违反公平竞赛的行为
            
            执行规则：

            赛道裁判会同时出示黑白旗及违规车手的号码牌，以明确责任方。
            若车手收到警告后仍不改正，可能被追加处罚，例如：

            - 加时罚（Time Penalty）：在进站时静止罚时（期间禁止任何操作），或比赛结束后直接向车手的总用时追加罚时（如+5秒、+10秒），可能降低其最终排名。
            
            - 进站通过罚（Drive-Through Penalty）：车手必须立即驶入维修区通道并全程保持限速通过，不得停留，损失约20秒时间
            。
            - 停站罚（Stop-and-Go Penalty）：车手需进站并在停车区静止罚时（期间禁止任何操作），完成后才能重返赛道，时间损失更大。

            该旗帜旨在通过即时警告维护比赛公平性，避免直接过罚，同时约束车手行为。
            
            """
        case "Black flag with an orange disc":"""
            （黑旗+橙色圆盘），俗称“肉丸旗”（Meatball Flag），是F1中用于警示赛车机械故障的特殊信号旗。

            当车手被出示此旗时，表示其赛车存在安全隐患（如部件松动、液体泄漏等），需立即处理以避免引发赛道风险。

            执行规则：

            1. 裁判会同时展示该旗及车手号码牌，收到信号的车手必须尽快返回维修区，由车队检查并修复问题（若可现场解决）。
            2. 若车手无视此旗未及时进站，赛事干事可能对其追加处罚（如黑旗强制退赛）。

            核心作用：

            - 强制车队及时处理机械故障，防止故障赛车威胁其他车手安全。
            - 避免因车辆问题引发更严重的事故或赛道拥堵。

            总结：肉丸旗是F1中“先维修，后裁决”的预防性措施，平衡了竞赛公平与赛道安全。
            """
        default:
            """
            Unknown
            """
        }
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading ,spacing: 10){
                HStack(alignment: .center) {
                    Image(title)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                    Text(LocalizedStringKey(title))
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(locale.language.languageCode?.identifier == "zh" ? flagDescriptionZH : flagDescriptionUS)
                    .font(.subheadline)
            }
            .padding(.horizontal)
            Spacer()
                .frame(height: 30)
        }
    }
}


#Preview {
    NewRaceFlag()
        .environment(\.locale, .init(identifier: "zh-Hans"))
    
}
#Preview {
    NewRaceFlag()
        .environment(\.locale, .init(identifier: "en"))
}

