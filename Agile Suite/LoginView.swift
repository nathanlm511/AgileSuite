//
//  LoginView.swift
//  Agile Suite
//
//  Created by Thuc Phan on 12/3/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI

struct LoginView : View {
    
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
    
    @State private var enteredPassword = ""
    @State private var showInvalidPasswordAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
//                        Image("Welcome")
//                            .padding(.top, 30)
                        
//                        Text("")
//                            .font(.headline)
//                            .padding()
                        
                        Image("login_image")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 300, maxWidth: 600)
                            .padding()
                        
                        SecureField("Password", text: $enteredPassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 300, height: 36)
                            .padding()
                        
                        HStack {
                            
                            Button(action: {
                                /*
                                 UserDefaults provides an interface to the user’s defaults database,
                                 where you store key-value pairs persistently across launches of your app.
                                 */
                                // Retrieve the password from the user’s defaults database under the key "Password"
                                let validPassword = UserDefaults.standard.string(forKey: "Password")
                                
                                /*
                                 If the user has not yet set a password, validPassword = nil
                                 In this case, allow the user to login.
                                 */
                                
                                if validPassword == nil || self.enteredPassword == validPassword {
                                    userData.userAuthenticated = true
                                    self.showInvalidPasswordAlert = false
                                } else {
                                    self.showInvalidPasswordAlert = true
                                }
                                
                            })
                            {
                                Text("Login")
                                    .frame(width: 125, height: 36, alignment: .center)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .strokeBorder(Color.black, lineWidth: 1)
                                    )
                                    .alert(isPresented: $showInvalidPasswordAlert, content: { self.invalidPasswordAlert })
                                
                                
                            } // end of button
                            
                                
                                let validPassword = UserDefaults.standard.string(forKey: "Password")
                                
                                if validPassword != nil {
                                    
                                    NavigationLink(destination: PasswordReset()) {
                                        Text("Forgot Password")
                                            .frame(width: 220, height: 36, alignment: .center)
                                            .background(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .strokeBorder(Color.black, lineWidth: 1)
                                            )
                                    }
                                    
                                } // end of if statement
                                
                            
                            
                            
                        } // End of HStack
                    }   // End of VStack
                }   // End of ScrollView
            }   // End of ZStack
        }
        
    }   // End of var
    
    /*
     ------------------------------
     MARK: - Invalid Password Alert
     ------------------------------
     */
    var invalidPasswordAlert: Alert {
        Alert(title: Text("Invalid Password!"),
              message: Text("Please enter a valid password to unlock the app!"),
              dismissButton: .default(Text("OK")) )
        
        // Tapping OK resets @State var showInvalidPasswordAlert to false.
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
