//
//  ProjectItem.swift
//  Agile Suite
//
//  Created by Thuc Phan on 12/7/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import SwiftUI
 
struct ProjectItem: View {
   
    // ❎ Input parameter: CoreData ParkVisit Entity instance reference
    let project: Project
   
    // ❎ CoreData FetchRequest returning all ParkVisit entities in the database
    @FetchRequest(fetchRequest: Project.allProjectsFetchRequest()) var allPastProjects: FetchedResults<Project>
   
    // ❎ Refresh this view upon notification that the managedObjectContext completed a save.
    // Upon refresh, @FetchRequest is re-executed fetching all ParkVisit entities with all the changes.
    @EnvironmentObject var userData: UserData
   
    var body: some View {
        HStack {
            // This function is given in PhotoImageFromBinaryData.swift
            photoImageFromBinaryData(binaryData: project.photo!.projectPhoto!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0, height: 60.0)
           
            VStack(alignment: .leading) {
                /*
                 ?? is called nil coalescing operator.
                 IF visit.fullName is not nil THEN
                 unwrap it and return its value
                 ELSE return ""
                 */
                Text(project.name ?? "")
                Text(project.dateCreated ?? "")
                Text(project.company ?? "")
            }
                // Set font and size for the whole VStack content
                .font(.system(size: 14))
        }
    }
}
