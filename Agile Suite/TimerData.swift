//
//  TimerData.swift
//  Agile Suite
//
//  Created by CS3714 on 12/1/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import SwiftUI
 
// AudioPlayer declarations
var clickSoundAudioPlayer: AVAudioPlayer?
var applaudSoundAudioPlayer: AVAudioPlayer?
 
/*
 ****************************
 MARK: - Create Audio Players
 ****************************
 */
// This function is called upon app launch in AppDelegate
public func createAudioPlayers() {
   
    if let clickSoundAudioFileUrl = Bundle.main.url(forResource: "ClickSound",
                                          withExtension: "wav",
                                          subdirectory: "Sound Files") {
        do {
            clickSoundAudioPlayer = try AVAudioPlayer(contentsOf: clickSoundAudioFileUrl)
            clickSoundAudioPlayer!.prepareToPlay()
        } catch {
            print("Unable to create clickSoundAudioPlayer!")
        }
 
    } else {
        print("Unable to find ClickSound in the main bundle!")
    }
   
    if let applaudSoundAudioFileUrl = Bundle.main.url(forResource: "ApplaudSound",
                                          withExtension: "wav",
                                          subdirectory: "Sound Files") {
        do {
            applaudSoundAudioPlayer = try AVAudioPlayer(contentsOf: applaudSoundAudioFileUrl)
            applaudSoundAudioPlayer!.prepareToPlay()
        } catch {
            print("Unable to create applaudSoundAudioPlayer!")
        }
 
    } else {
        print("Unable to find ApplaudSound in the main bundle!")
    }
   
}
