//
//  UserData.swift
//  Agile Suite
//
//  Created by CS3714 on 12/1/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
 
final class UserData: ObservableObject {
    
    // ❎ Subscribe to notification that the managedObjectContext completed a save
    @Published var savedInTicketsDatabase =  NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave)
 
    // Instance Variables for Game Play Duration Timer
    var durationTimer = Timer()
    var startTime: Double = 0
    var timeElapsed: Double = 0
    var timerHours: UInt8 = 0
    var timerMinutes: UInt8 = 0
    var timerSeconds: UInt8 = 0
    var timerMilliseconds: UInt8 = 0
    var timerEndedOnce: Bool = false
   
    @Published var gamePlayDuration = ""
   
    public func startDurationTimer() {
        /*
         Schedule a timer to invoke the updateTimeLabel() function given below
         after 0.01 second in a loop that repeats itself until it is stopped.
         */
        durationTimer = Timer.scheduledTimer(timeInterval: 0.01,
                                             target: self,
                                             selector: (#selector(self.updateTimeLabel)),
                                             userInfo: nil,
                                             repeats: true)
       
        // Time at which the timer starts
        startTime = Date().timeIntervalSinceReferenceDate
        
        timerEndedOnce = false
    }
   
    public func stopDurationTimer() {
        durationTimer.invalidate()
        gamePlayDuration = ""
    }
   
    @objc func updateTimeLabel(){
        // Calculate total time since timer started in seconds
        timeElapsed = 10 - (Date().timeIntervalSinceReferenceDate - startTime)
        
        if (timeElapsed >= 0) {
            // Calculate hours
            timerHours = UInt8(timeElapsed / 3600)
            timeElapsed = timeElapsed - (TimeInterval(timerHours) * 3600)
           
            // Calculate minutes
            timerMinutes = UInt8(timeElapsed / 60.0)
            timeElapsed = timeElapsed - (TimeInterval(timerMinutes) * 60)
           
            // Calculate seconds
            timerSeconds = UInt8(timeElapsed)
            timeElapsed = timeElapsed - TimeInterval(timerSeconds)
           
            // Calculate milliseconds
            timerMilliseconds = UInt8(timeElapsed * 100)
           
            // Create the time string and update the label
            let timeString = String(format: "%02d:%02d:%02d.%02d", timerHours, timerMinutes, timerSeconds, timerMilliseconds)
           
            gamePlayDuration = timeString
        }
        else {
            if (!timerEndedOnce) {
                applaudSoundAudioPlayer!.play()
                timerEndedOnce = true
            }
        }
    }
    
}
