//
//  SearchDatabase.swift
//  Agile Suite
//
//  Created by Thuc Phan on 12/8/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//


import Foundation
import SwiftUI
import CoreData

// Global Variables
var searchCategory = ""
var searchQuery = ""

struct SearchDatabase: View {
    
    let searchCategoriesList = ["All", "Project Name", "Company Name", "Project Technologies", "Project Description"]
    
    @State private var selectedSearchCategoryIndex = 0
    @State private var searchFieldValue = ""
    
    var body: some View {
        
            Form {
                Section(header: Text("Select a Search Category")) {
                    
                    Picker("", selection: $selectedSearchCategoryIndex) {
                        ForEach(0 ..< searchCategoriesList.count, id: \.self) {
                            Text(self.searchCategoriesList[$0])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(minWidth: 300, maxWidth: 500, alignment: .leading)
                    
                }
                
                Section(header: Text("Search Query under Selected Category")) {
                    HStack {
                        TextField("Enter Search Query", text: $searchFieldValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .frame(width: 275, height: 36)
                        
                        // Button to clear the text field
                        Button(action: {
                            self.searchFieldValue = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }   // End of HStack
                    .padding(.horizontal)
                }
                
                Section(header: Text("Show Search Results")) {
                    NavigationLink(destination: showSearchResults()) {
                        HStack {
                            Image(systemName: "list.bullet")
                            Text("Show Search Results")
                                .font(.headline)
                        }
                    }
                }
                
            }
            .navigationBarTitle(Text("Search Core Database"), displayMode: .inline)
        
        
        .customNavigationViewStyle()
        
        
    } // end of Body
    
    func showSearchResults() -> some View {
        
        let queryTrimmed = self.searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        if (queryTrimmed.isEmpty) {
            return AnyView(missingSearchQueryMessage)
        }
        searchCategory = self.searchCategoriesList[self.selectedSearchCategoryIndex]
        searchQuery = self.searchFieldValue
        
        
        return AnyView(ResultsList())
    }
    
    var missingSearchQueryMessage: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .imageScale(.large)
                .font(Font.title.weight(.medium))
                .foregroundColor(.red)
                .padding()
            Text("Search Query Missing!\nPlease enter a search query to be able to search the database!")
                .fixedSize(horizontal: false, vertical: true)   // Allow lines to wrap around
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color(red: 1.0, green: 1.0, blue: 240/255))     // Ivory color
    }
}
