//
//  Break.swift
//  Agile Suite
//
//  Created by CS3714 on 12/1/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import SwiftUI
import AVFoundation

struct Break: View {
    
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
    
    @State private var onBreak = false
    
    @State var timerDuration = "10"
    
    @State private var showInvalidDurationAlert = false
    
    var body: some View {
        VStack (alignment: .center) {
            Text("Take a Break!")
                .foregroundColor(Color.red)
                .font(.largeTitle)
                .padding(6)
            Text("Enter the break duration below: ")
            HStack {
                Spacer()
                TextField("Break Duration: ", text: $timerDuration)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer()
            }
                
            if !onBreak {
                //-----------------
                // Start Break Button
                //-----------------
                Button(action: {
                    self.startBreak(timerDuration: timerDuration)
                }) {
                    Text("Start Break")
                        .padding(5)
                        .padding(.horizontal)
                }
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(Color.blue, lineWidth: 1)
                    )
                .alert(isPresented: $showInvalidDurationAlert, content: { self.invalidDurationAlert })
            }
            else {
                //--------------
                // Stop Break Button
                //--------------
                Button(action: {
                    self.stopBreak()
                }) {
                    Text("Stop Break")
                        .padding(5)
                        .padding(.horizontal)
                }
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(Color.blue, lineWidth: 1)
                    )
            }
            
            //-------------------------
            // Break Duration Timer
            //-------------------------
            Text(userData.gamePlayDuration)
                .padding(20)
            
            Spacer()
        }
        
    }
    
    /*
     -----------------
     MARK: - Start Break
     -----------------
     */
    func startBreak(timerDuration: String) {
        if (Int(timerDuration) != nil){
            self.userData.startDurationTimer(timerDuration: Int(timerDuration) ?? 10)
            onBreak = true
        }
        else {
            self.showInvalidDurationAlert = true
        }
    }
    
    /*
     --------------------------------
     MARK: - Invalid timer duration
     --------------------------------
     */
    var invalidDurationAlert: Alert {
        Alert(title: Text("Invalid timer duration!"),
              message: Text("Timer duration must be an int"),
              dismissButton: .default(Text("OK")) )
        /*
         Tapping OK resets @State var showMissingInputDataAlert to false.
         In this example, no action is taken when OK is tapped.
         */
    }
    
    /*
     -----------------
     MARK: - Start Break
     -----------------
     */
    func stopBreak() {
        self.userData.stopDurationTimer()
        onBreak = false
    }
}

struct Break_Previews: PreviewProvider {
    static var previews: some View {
        Break()
    }
}
