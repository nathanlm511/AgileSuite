//
//  PasswordReset.swift
//  Agile Suite
//
//  Created by Thuc Phan on 12/3/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI


struct PasswordReset: View {
    
    @State private var showEnteredValues = false
    @State private var securityAnswer = ""
    
    var body: some View {
        
        Form {
            Section(header: Text("Show Entered Values")) {
                Toggle(isOn: $showEnteredValues) {
                    Text("Show Entered Values")
                }
            }
            
            Section(header: Text("Security Question")) {
                let securityQuestion = UserDefaults.standard.string(forKey: "securityQuestion")
                Text(securityQuestion!)
            }
            
            Section(header: Text("Security Question")) {
                
                HStack {
                    TextField("Enter Answer", text: $securityAnswer)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 275, height: 36)
                    
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
            
            let validAnswer = UserDefaults.standard.string(forKey: "securityAnswer")
            
            if validAnswer != self.securityAnswer {
                Section(header: Text("Incorrect Answer")) {
                    Text("Answer to the Security Question is Incorrect!")
                        .font(.system(size: 14))
                }
            } else {
                Section(header: Text("Go to settings to reset password")) {
                    NavigationLink(destination: Settings()) {
                        HStack{
                            Image(systemName: "gear")
                                .foregroundColor(.blue)
                            Text("Show Settings")
                        }
                        
                    }
                    
                }
            }
            
        }
        .navigationBarTitle(Text("Reset Password"), displayMode: .inline)
    }
    
}
