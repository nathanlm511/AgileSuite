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
    
    var body: some View {
        VStack (alignment: .center) {
            HStack {
                if !onBreak {
                    //-----------------
                    // Start Break Button
                    //-----------------
                    Button(action: {
                        self.startBreak()
                    }) {
                        Text("Start Break")
                            .padding(5)
                            .padding(.horizontal)
                    }
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(Color.blue, lineWidth: 1)
                        )
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
               
            }   // End of HStack
            
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
    func startBreak() {
        self.userData.startDurationTimer()
        onBreak = true
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
