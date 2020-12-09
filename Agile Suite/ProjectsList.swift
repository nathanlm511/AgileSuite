//
//  ProjectsList.swift
//  Agile Suite
//
//  Created by Thuc Phan on 12/7/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

struct ProjectsList: View {
  
   // ❎ CoreData managedObjectContext reference
   @Environment(\.managedObjectContext) var managedObjectContext
  
   // ❎ CoreData FetchRequest returning all ParkVisit entities in the database
   @FetchRequest(fetchRequest: Project.allProjectsFetchRequest()) var allPastProjects: FetchedResults<Project>
  
   // ❎ Refresh this view upon notification that the managedObjectContext completed a save.
   // Upon refresh, @FetchRequest is re-executed fetching all Project entities with all the changes.
   @EnvironmentObject var userData: UserData
  
   var body: some View {
           List {
               /*
                Each NSManagedObject has internally assigned unique ObjectIdentifier
                used by ForEach to display allParkVisits in a dynamic scrollable list.
                */
               ForEach(self.allPastProjects) { aProject in
                   NavigationLink(destination: ProjectDetails(project: aProject)) {
                       ProjectItem(project: aProject)
                   }
               }
               .onDelete(perform: delete)
              
           }   // End of List
               .navigationBarTitle(Text("Projects"), displayMode: .inline)
              
               // Place the Edit button on left and Add (+) button on right of the navigation bar
               .navigationBarItems(leading: EditButton(), trailing:
                   NavigationLink(destination: AddProject()) {
                       Image(systemName: "plus")
               })
          
           .customNavigationViewStyle()  // Given in NavigationStyle.swift
   }
  
   /*
    ----------------------------------
    MARK: - Delete Selected Park Visit
    ----------------------------------
    */
   func delete(at offsets: IndexSet) {
       /*
       'offsets.first' is an unsafe pointer to the index number of the array element
       to be deleted. It is nil if the array is empty. Process it as an optional.
       */
       if let index = offsets.first {

           let projectEntityToDelete = self.allPastProjects[index]

           // ❎ CoreData Delete operation
           self.managedObjectContext.delete(projectEntityToDelete)

           // ❎ CoreData Save operation
           do {
               try self.managedObjectContext.save()
           } catch {
               print("Unable to delete!")
           }
       }
   }
  
}

struct ProjectsList_Previews: PreviewProvider {
   static var previews: some View {
       ProjectsList()
   }
}
