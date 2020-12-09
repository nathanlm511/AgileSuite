//
//  MainProjectView.swift
//  Agile Suite
//
//  Created by Thuc Phan on 12/8/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

struct MainProjectView: View {
    
    var tabChoices = ["Projects", "Search Projects"]
    @State private var index = 0
    
    var body: some View {
        
        NavigationView {
            VStack {
               // Segmented Picker: Part 3 of 3
               Picker("", selection: $index) {
                   ForEach(0 ..< tabChoices.count, id: \.self) {
                       Text(self.tabChoices[$0])
                   }
               }
               .pickerStyle(SegmentedPickerStyle())
               .padding()
              
                if (index == 0) {
                    ProjectsList()
                }
                else if (index == 1) {
                    SearchDatabase()
                }
                
                Spacer()
           }

            .navigationBarTitle(Text("Projects"), displayMode: .inline)
            
        }
        
        
    }

}
