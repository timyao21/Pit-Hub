//
//  DriverNicknameView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 4/9/25.
//

import SwiftUI
import SwiftData

struct DriverNicknameView: View {
    @Environment(\.modelContext) var context
    @State var viewModel = DriverNicknameViewModel()
    
    @State private var nickname: String = ""
    @State private var error: String? = ""
    @State private var isAddingPresented: Bool = false
    @Query(sort: \DriverNickname.driverId) var driverNickname: [DriverNickname]
    
    var body: some View {
        NavigationStack{
                List{
                    Section("Add"){
                        Button {
                            isAddingPresented = true
                        } label:{
                            HStack{
                                Text("Customize Driver Nicknames")
                                    .font(.title3)
                                    .bold()
                                Spacer()
                                Image(systemName: "plus")
                            }
                            .foregroundColor(Color(S.pitHubIconColor))
                        }
                    }
                    Section(){
                        ForEach(driverNickname){ driver in
                            HStack{
                                Text(driver.driverId)
                                Spacer()
                                Text(driver.nickname)
                                    .bold()
                                    .foregroundColor(Color(S.pitHubIconColor))
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                context.delete(driverNickname[index])
                            }
                        }
                    }
                }
                .navigationTitle("Driver Nicknames")
        }
        .sheet(isPresented: $isAddingPresented) {
            VStack(alignment: .leading, spacing: 5){
                HStack {
                    Text("Add Driver")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Button(action: { isAddingPresented = false }) {
                        Image(systemName: "xmark")
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
                .padding(.bottom, 15)

                Text("\(error ?? "")")
                
                HStack{
                    Text("Select a Driver")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Picker(selection: $viewModel.selectedDriverId, label: Text("Select a Driver")) {
                        ForEach(viewModel.drivers) { driver in
                            HStack{
                                Text(NSLocalizedString(driver.familyName, comment: "Driver family name"))
                            }
                            .tag(driver.driverId)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .tint(Color(S.pitHubIconColor))
                }
                
                TextField("Enter the Nickname", text: $nickname)
                    .font(.system(size: 20))          // Increase font size.
                    .padding(12)                      // Add extra padding inside the text field.
                    .frame(height: 50)                // Set a consistent height.
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(Color.gray, lineWidth: 1)
                    )
                
                Button(action: {
                    guard !viewModel.selectedDriverId.isEmpty else {
                        error = "Please select a driver."
                        return
                    }
                    
                    guard !nickname.isEmpty else {
                        error = "Please enter a nickname."
                        return
                    }
                    
                    let newDriverNickname = DriverNickname(driverId: viewModel.selectedDriverId, nickname: nickname)
                    
                    // Save the Data
                    do {
                        context.insert(newDriverNickname)
                        try context.save()
                    } catch {
                        // Handle duplicate insertion error
                        print("Error saving context: \(error)")
                    }
                    
                    // Reset the Data
                    viewModel.selectedDriverId = ""
                    nickname = ""
                    isAddingPresented = false
                }) {
                    Text("Save")
                        .font(.headline)              // Custom font style (change as needed)
                        .foregroundColor(.white)      // Text color
                        .frame(maxWidth: .infinity, minHeight: 35)
                        .padding(.vertical, 8)
                }
                .background(Color(S.pitHubIconColor))
                .cornerRadius(8)
                .padding(.vertical)
                
                Spacer()
            }
            .presentationDetents([.fraction(0.4)])
            .padding()
        }
        .onAppear(){
            Task{
             await viewModel.fetchAllDrivers()
            }
        }
    }
}

#Preview {
    DriverNicknameView()
}
