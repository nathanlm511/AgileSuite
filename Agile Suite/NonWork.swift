//
//  NonWork.swift
//  Agile Suite
//
//  Created by CS3714 on 12/1/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import SwiftUI

struct NonWork: View {
    
    // Segmented Picker: Part 1 of 3
    let selectionList = ["Break", "Inspiration", "Stress Relief"]
   
    // Segmented Picker: Part 2 of 3
    @State private var selectedIndex = 0
    
    var body: some View {
        VStack {
           // Segmented Picker: Part 3 of 3
           Picker("", selection: $selectedIndex) {
               ForEach(0 ..< selectionList.count, id: \.self) {
                   Text(self.selectionList[$0])
               }
           }
           .pickerStyle(SegmentedPickerStyle())
           .padding()
          
            if (selectedIndex == 0) {
                Break()
            }
            else if (selectedIndex == 1) {
                Quotes()
            }
            else if (selectedIndex == 2) {
                Game()
            }
            
            Spacer()
       }
    }
}

struct NonWork_Previews: PreviewProvider {
    static var previews: some View {
        NonWork()
    }
}
