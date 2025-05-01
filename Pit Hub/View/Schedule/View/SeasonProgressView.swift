////
////  SeasonProgressView.swift
////  Pit Hub
////
////  Created by Junyu Yao on 2/20/25.
////
//
//import SwiftUI
//
//struct SeasonProgressView: View {
////    @ObservedObject var viewModel: IndexViewModel
//    @Bindable var viewModel: IndexViewModel
//    
//    private var totalGP: Int { viewModel.raceCalendar.count }
//    private var pastGP: Int { viewModel.raceCalendarPast.count }
//    
//    @State private var animatedProgress: CGFloat = 0
//    
//    private var progress: CGFloat {
//        totalGP > 0 ? CGFloat(pastGP) / CGFloat(totalGP) : 0
//    }
//    
//    var body: some View {
//        
//            VStack(alignment: .leading) {
//                Text("Season Progress")
//                    .font(.headline)
//                    .padding(.bottom, 5)
//                
//                GeometryReader { geometry in
//                    ZStack(alignment: .leading) {
//                        Rectangle()
//                            .fill(Color.gray.opacity(0.3))
//                            .frame(width: geometry.size.width, height: 15)
//                            .cornerRadius(5)
//                        
//                        Rectangle()
//                            .fill(Color.red)
//                            .frame(width: geometry.size.width * animatedProgress, height: 15)
//                            .cornerRadius(5)
//                            .animation(.easeOut(duration: 1.0), value: animatedProgress)
//                    }
//                }
//                .frame(height: 15)
//                
//                Text("\(pastGP)/\(totalGP) GP Completed")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//                    .padding(.top, 5)
//            }
//        
//            .onAppear {
//                DispatchQueue.main.async {
//                    animatedProgress = progress
//                }
//            }
//            .onChange(of: pastGP) { oldValue, newValue in
//                DispatchQueue.main.async {
//                    animatedProgress = progress
//                }
//            }
//    }
//}
