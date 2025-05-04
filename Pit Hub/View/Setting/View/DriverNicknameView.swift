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
                    Section("Edit"){
                        Button {
                            isAddingPresented = true
                        } label:{
                            HStack{
                                Text("Customize Driver Nicknames")
                                    .font(.subheadline)
                                    .bold()
                                Spacer()
                                Image(systemName: "plus")
                            }
                            .foregroundColor(Color(S.pitHubIconColor))
                        }
                    }
                    Section("Nicknames"){
                        ForEach(driverNickname){ driver in
                            DriverNicknameRowView(for: driver)
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                context.delete(driverNickname[index])
                            }
                        }
                    }
                }
                .navigationTitle("Driver Nickname")
                .overlay {
                    if driverNickname.isEmpty {
                        VStack(spacing: 10){
                            Image(systemName: "heart.text.clipboard.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 66)
                                .foregroundColor(.primary)
                            Text("No Nicknames")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.primary)
                            Text("Start adding driver nicknames!")
                                .foregroundColor(.secondary)
                        }
                    }
                }
        }
        .sheet(isPresented: $isAddingPresented) {
            VStack(alignment: .leading, spacing: 8){
                HStack {
                    Text("Add a Nickname")
                        .font(.title2)
                        .bold()
                    Spacer()
                    Button(action: { isAddingPresented = false }) {
                        Image(systemName: "xmark")
                            .padding(5)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                }

                Text(LocalizedStringKey(error ?? ""))
                    .font(.caption)
                    .foregroundColor(.red)
                
                HStack{
                    Text("Select a Driver")
                        .font(.system(size: 18))
                        .foregroundColor(.secondary)
                    Spacer()
                    Picker("Select Driver", selection: $viewModel.selectedDriverId) {
                        ForEach(viewModel.drivers, id: \.driverId) { driver in
                            Text(LocalizedStringKey(driver.familyName))
                                .tag(driver.driverId)          // attach the ID once
                        }
                    }
                    .pickerStyle(.menu)                        // shorthand style call
                    .tint(Color(S.pitHubIconColor))            // keep your custom brand color
                }
                
                TextField("Enter the Nickname", text: $nickname)
                    .font(.system(size: 18))          // Increase font size.
                    .padding(12)                      // Add extra padding inside the text field.
                    .frame(height: 50)                // Set a consistent height.
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(Color.gray, lineWidth: 1)
                    )
                
                Spacer()
                
                Button(action: {
                    guard !viewModel.selectedDriverId.isEmpty else {
                        error = "Driver not in position! Pick your racer first!"
                        return
                    }
                    
                    guard !nickname.isEmpty else {
                        error = "Engine stall! Nickname can't be empty!"
                        return
                    }
                    
                    guard nickname.count <= 7 else {
                        error = "Pit crew won't approve text over 7 words."
                        return
                    }
                    
                    if let selectedDriver = viewModel.drivers.first(where: { $0.id == viewModel.selectedDriverId }){
                        
                        let newDriverNickname = DriverNickname(driverId: viewModel.selectedDriverId, driver: selectedDriver, nickname: nickname)
                        
                        // Save the Data
                        do {
                            context.insert(newDriverNickname)
                            try context.save()
                        } catch {
                            // Handle duplicate insertion error
                            print("Error saving context: \(error)")
                        }
                    } else{
                        error = "Error saving context: No driver found"
                        return
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

struct DriverNicknameRowView: View {
    let driverNickname: DriverNickname
    
    init(for driver: DriverNickname) {
        self.driverNickname = driver
    }
    
    var body: some View {
        HStack(spacing: 10){
            Text(driverNickname.driver.permanentNumber ?? "")
                .font(.custom(S.orbitron, size: 16))
                .fontWeight(.bold)
                .frame(width: 30)
            Text(LocalizedStringKey(driverNickname.driver.familyName))
                .frame(width: 88, alignment: .leading)
            Spacer()
            Image(systemName: "arrowshape.right.fill")
            Text(driverNickname.nickname)
                .bold()
                .foregroundColor(Color(S.pitHubIconColor))
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}
