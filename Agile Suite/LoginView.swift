//
//  LoginView.swift
//  Agile Suite
//
//  Created by Thuc Phan on 12/3/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI
/*
 ------------------------------
 MARK: - import needed for biometrics
 ------------------------------
 */
import LocalAuthentication

struct LoginView : View {
    
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
    
    @State private var enteredPassword = ""
    @State private var showInvalidPasswordAlert = false
    /*
     -----------------------------------------------------------------
     MARK: - State Variable that will store whether the app is showing
     it's protected data or not
     -----------------------------------------------------------------
     */
    @State private var isUnlocked = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
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
                                 If the user has not yet set a password, validPassword = nil. Or if the entered passwordf is correct. Or if the FaceID authentication is correct.
                                 
                                 In this case, allow the user to login.
                                 */
                                
                                if validPassword == nil || self.enteredPassword == validPassword || self.isUnlocked {
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
                        .onAppear(perform: authenticate)
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
    
    /*
     ------------------------------------
     MARK: - Create authenticate function
     for use in Face ID
     ------------------------------------
     */
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // there was a problem
                        self.isUnlocked = false
                    }
                }
            }
        } else {
            // no biometrics
        }
    }
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
