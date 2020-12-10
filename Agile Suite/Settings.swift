//
//  Settings.swift
//  Agile Suite
//
//  Created by Thuc Phan on 12/3/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI


struct Settings: View {
    
    
    @State private var securityAnswer = ""
    @State private var passwordEntered = ""
    @State private var passwordVerified = ""
    @State private var showEnteredValues = false
    @State private var showUnmatchedPasswordAlert = false
    @State private var showPasswordSetAlert = false
    
    let securityQuestions = ["In what city or town did your mother and father meet?", "In what city or town were you born?", "What did you want to be when you grew up?", "What do you remember most from your childhood?", "What is the name of the boy or girl that you first kissed?", "What is the name of the first school you attended?", "What is the name of your favorite childhood friend?", "What is the name of your first pet?", "What is the name of your first pet?", "What is your mother's maiden name?", "What was your favorite place to visit as a child?"]
    @State private var selectedIndex = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Show Entered Values")) {
                    Toggle(isOn: $showEnteredValues) {
                        Text("Show Entered Values")
                    }
                }
                
                Section(header: Text("Select a Security Question")) {
                    
                    Picker("Selected State:", selection: $selectedIndex) {
                        ForEach(0 ..< securityQuestions.count, id: \.self) {
                            Text(self.securityQuestions[$0])
                        }
                        .font(.system(size: 12))
                    }
                    
                }
                Section(header: Text("Enter Answer to selected security question")) {
                    HStack {
                        if self.showEnteredValues {
                            TextField("Enter Answer", text: $securityAnswer)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 275, height: 36)
                            
                            
                        } else {
                            SecureField("Enter Answer", text: $securityAnswer)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 275, height: 36)
                            
                        }
                        
                        
                        // Button to clear the text field
                        Button(action: {
                            self.securityAnswer = ""
                        }) {
                            Image(systemName: "multiply.circle")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }
                    
                }
                
                Section(header: Text("Enter Password")) {
                    HStack {
                        if self.showEnteredValues {
                            TextField("Enter Password", text: $passwordEntered)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 275, height: 36)
                        } else {
                            SecureField("Enter Password", text: $passwordEntered)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 275, height: 36)
                            
                        }
                        
                        // Button to clear the text field
                        Button(action: {
                            self.passwordEntered = ""
                        }) {
                            Image(systemName: "multiply.circle")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }
                    
                }
                
                Section(header: Text("Verify Password")) {
                    HStack {
                        if self.showEnteredValues {
                            TextField("Verify Password", text: $passwordVerified)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 275, height: 36)
                        } else {
                            SecureField("Verify Password", text: $passwordVerified)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 275, height: 36)
                            
                        }
                        
                        // Button to clear the text field
                        Button(action: {
                            self.passwordVerified = ""
                        }) {
                            Image(systemName: "multiply.circle")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }
                }
                
                Section(header: Text("Set Password")) {
                    
                    Button(action: {
                        if !passwordEntered.isEmpty {
                            if passwordEntered == passwordVerified {
                                /*
                                 UserDefaults provides an interface to the user’s defaults database,
                                 where you store key-value pairs persistently across launches of your app.
                                 */
                                // Store the password, security question, and answer in the user’s defaults database under the key "Password"
                                UserDefaults.standard.set(self.passwordEntered, forKey: "Password")
                                UserDefaults.standard.set(self.securityQuestions[self.selectedIndex], forKey: "securityQuestion")
                                UserDefaults.standard.set(self.securityAnswer, forKey: "securityAnswer")
                                
                                self.securityAnswer = ""
                                self.passwordEntered = ""
                                self.passwordVerified = ""
                                self.showPasswordSetAlert = true
                            } else {
                                self.showUnmatchedPasswordAlert = true
                            }
                        }
                    }) {
                        Text("Set Password to Unlock App")
                            .frame(width: 300, height: 36, alignment: .center)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color.black, lineWidth: 1)
                            )
                    }
                    .alert(isPresented: $showUnmatchedPasswordAlert, content: { self.unmatchedPasswordAlert })
                }
            }
        }

        }
        

    
    /*
     --------------------------
     MARK: - Password Set Alert
     --------------------------
     */
    var passwordSetAlert: Alert {
        Alert(title: Text("Password Set!"),
              message: Text("Password you entered is set to unlock the app!"),
              dismissButton: .default(Text("OK")) )
    }
    
    /*
     --------------------------------
     MARK: - Unmatched Password Alert
     --------------------------------
     */
    var unmatchedPasswordAlert: Alert {
        Alert(title: Text("Unmatched Password!"),
              message: Text("Two entries of the password must match!"),
              dismissButton: .default(Text("OK")) )
    }
    
}
