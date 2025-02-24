////
////  LoginView.swift
////  Pit Hub
////
////  Created by Junyu Yao on 12/4/24.
////
//
//import SwiftUI
//import FirebaseAuth
//
//struct LoginView: View {
//    @State private var email: String = "1@2.com"
//    @State private var password: String = "123456"
//    @State private var isLoginSuccessful: Bool = false
//    @State private var showAlert: Bool = false
//    @Environment(\.presentationMode) var presentationMode
//
//    var body: some View {
//        ZStack {
//            Rectangle()
//                .fill(Color(S.primaryBackground))
//                .ignoresSafeArea()
//            VStack {
//                HStack{
//                    Image("PitIcon")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 100, height: 100)
//                    Text("Pit Hub")
//                        .font(.custom(S.orbitron, size: 40))
//                        .font(.title)
//                        .foregroundColor(Color(S.pitHubIconColor))
//                        .bold()
//                }
//                Text("Login")
//                    .font(.custom(S.orbitron, size: 20))
//                    .padding(.bottom, 40)
//                    .bold()
//                
//                TextField("Username/Email", text: $email)
//                    .padding()
//                    .background(Color(.systemGray4))
//                    .cornerRadius(10.0)
//                    .padding(.horizontal, 20)
//                    .padding(.bottom, 20)
//                
//                SecureField("Password", text: $password)
//                    .padding()
//                    .background(Color(.systemGray4))
//                    .cornerRadius(10.0)
//                    .padding(.horizontal, 20)
//                    .padding(.bottom, 20)
//                
//                Button(action: {
//                    authenticateUser()
//                }) {
//                    HStack {
//                        Text("登录")
//                            .font(.custom(S.smileySans, size: 20))
//                        Image(systemName: "arrow.right.circle.fill")
//                            .resizable()
//                            .frame(width: 20, height: 20)
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(width: 160, height: 60)
//                    .background(
//                          LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .leading, endPoint: .trailing)
//                      )
//                    .cornerRadius(15.0)
//                }
//                .alert(isPresented: $showAlert) {
//                    Alert(title: Text("Login Failed"), message: Text("Incorrect username or password"), dismissButton: .default(Text("OK")))
//                }
//            }
//            .padding()
//        }
//    }
//    
//    func authenticateUser() {
//        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
//            if let e = error {
//                  print(e)
//                  showAlert = true
//              } else {
//                  print("User logged in successfully")
//                  isLoginSuccessful = true
//                  presentationMode.wrappedValue.dismiss()
//              }
//        }
//    }
//}
//
//#Preview {
//    LoginView()
//}
