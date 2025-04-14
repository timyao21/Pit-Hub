////
////  RaceFlagView.swift
////  Pit Hub
////
////  Created by Junyu Yao on 4/5/25.
////
//
//import SwiftUI
//
//struct RaceFlagView: View {
//    
//    var flagList: [String] = ["Red","Blue", "Red", "Yellow", "Green", "Black", "Black And White"]
//    // This state will hold the selected flag to scroll to.
//    @State private var scrollTarget: String?
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 3){
//            Group {
//                Text("F1 Race Flag Signals")
//                    .font(.title)
//                    .fontWeight(.bold)
//                Text("In F1 races, flag signals are an important way for the organizers to communicate real-time instructions and track conditions to the drivers using flags of different colors.")
//            }
//            .padding()
//
//            // Toolbar: a horizontally scrolling view that is NOT inside the ScrollViewReader.
//            ScrollView(.horizontal, showsIndicators: false) {
//                LazyHGrid(rows: [GridItem(.fixed(30))], spacing: 10) {
//                    ForEach(flagList, id: \.self) { flag in
//                        Button(action: {
//                            // Set the scroll target.
//                            scrollTarget = flag
//                        }) {
//                            Text("\(flag) Flag")
//                                .fontWeight(.semibold)
//                                .foregroundColor(Color(S.pitHubIconColor))
//                                .frame(maxWidth: .infinity)
//                                .lineLimit(1)
//                                .padding(5)
//                                .background(Color.gray.opacity(0.2))
//                                .cornerRadius(8)
//                        }
//                    }
//                }
//                .padding()
//            }
//            .frame(height: 40)
//            
//            Divider()
//                .padding()
//
//            
//            ScrollViewReader{ proxy in
//                
//                ScrollView {
//                    ForEach(flagList.indices, id: \.self) { index in
//                        let flag = flagList[index]
//                        FlagRowView(for: flag)
//                            .id(flag)
//                            .padding(.horizontal)
//                        
//                        if index != flagList.count - 1 {
//                            Divider()
//                                .padding()
//                        }
//                    }
//                }
//                .onChange(of: scrollTarget) { newTarget, _ in
//                    if let target = newTarget {
//                        withAnimation {
//                            proxy.scrollTo(target, anchor: .top)
//                        }
//                    }
//                }
//            }
//        }
//        .navigationTitle("F1 Race Flag Signals")
//    }
//}
//
//private struct FlagRowView: View {
//    @Environment(\.locale) var locale
//    let flag: String
//    let flagImage: String
//    let flagTitle: String
//    var flagDescriptionUS: String {
//        switch flag {
//        case "Blue":
//            return """
//The blue flag is primarily used to signal to a driver that they are about to be overtaken, though its interpretation shifts slightly depending on the session:
//            
//At all times:
//
//It is displayed to drivers exiting the pit lane, warning them that traffic is approaching from behind and advising extra caution when rejoining the circuit.
//
//During practice:
//
//It indicates that a faster car is immediately behind and poised to overtake. For instance, a driver on a 'cool-down' lap might receive the blue flag while a competitor is on a much quicker lap, such as during a qualifying simulation.
//
//During the race:
//
//The blue flag is shown to a driver who is about to be lapped (i.e., when faster cars catch up and the driver falls a full lap behind). When signaled, the driver must let the following car pass at the earliest opportunity. Ignoring three warnings will result in a penalty.
//"""
//        case "Red":
//            return """
//The red flag is displayed at the start line and across all marshal posts around the circuit when officials deem it necessary to halt a session or race. This decision may stem from critical incidents, hazardous track conditions, or extreme weather.
//
//During practice sessions and qualifying:
//
//Drivers must immediately reduce speed, cease overtaking, and proceed cautiously to their respective pit garages. 
//
//During the race:
//
//Drivers are similarly required to slow down, enter the pit lane in a controlled manner, and queue at the exit until further instructions are provided. The red flag ensures safety is prioritized, with all action suspended until normal conditions are restored.
//"""
//        default:
//            return "This is not a blue flag."
//        }
//    }
//    
//    init(for flag: String) {
//        self.flag = flag
//        self.flagImage = String("\(flag)Flag")
//        self.flagTitle = String("\(flag) Flag")
//    }
//    
//    
//    
//    var body: some View {
//        VStack(alignment: .leading){
//            HStack(alignment: .center){
//                Image(flagImage)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 50, height: 50)
//                Text(flagTitle)
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .padding()
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
//            Text(flagDescriptionUS)
//                .font(.subheadline)
//        }
//    }
//}
//
//#Preview {
//    RaceFlagView()
//}
