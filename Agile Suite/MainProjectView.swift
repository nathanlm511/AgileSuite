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
                Form{
                    Section(header: Text("")) {
                        NavigationLink(destination: SearchDatabase())
                        {
                            HStack {
                                Image("SearchDatabase")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100)
                                
                                Text("Search Project Database")
                            } // End of HStack
                        } // End of NavigationLink
                    }
                    Section(header: Text("")) {
                        NavigationLink(destination: ProjectsList())
                        {
                            HStack {
                                Image(systemName: "book.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100)
                                Text("View Project Database")
                            } // End of HStack
                        } // End of NavigationLink
                    }
                }
            }

            .navigationBarTitle(Text("Projects"), displayMode: .inline)
            
        }
        
        
    }

}
