//
//  ResultsList.swift
//  Agile Suite
//
//  Created by Thuc Phan on 12/8/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//


import Foundation
import SwiftUI

struct ResultsList: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // ❎ CoreData FetchRequest returning all Project entities in the database
    @FetchRequest(fetchRequest: Project.filteredProjectsFetchRequest(searchCategory: searchCategory, searchQuery: searchQuery)) var filteredProjects: FetchedResults<Project>
    
    var body: some View {
        if self.filteredProjects.isEmpty {
            SearchResultsEmpty()
        } else {
            List {
                
                ForEach(self.filteredProjects) { aProject in
                    NavigationLink(destination: ResultDetails(project: aProject)) {
                        ResultItem(project: aProject)
                    }
                }
                
            }   // End of List
            .navigationBarTitle(Text("Projects Found"), displayMode: .inline)
        }   // End of if
    }
}

struct ResultsList_Previews: PreviewProvider {
    static var previews: some View {
        ResultsList()
    }
}
