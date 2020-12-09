//
//  ProjectDetails.swift
//  Agile Suite
//
//  Created by Thuc Phan on 12/7/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI

struct ProjectDetails: View {
    
    
    // ❎ Input parameter: CoreData ParkVisit Entity instance reference
    let project: Project
   
    // ❎ CoreData FetchRequest returning all ParkVisit entities in the database
    @FetchRequest(fetchRequest: Project.allProjectsFetchRequest()) var allPastProjects: FetchedResults<Project>
   
    // ❎ Refresh this view upon notification that the managedObjectContext completed a save.
    // Upon refresh, @FetchRequest is re-executed fetching all ParkVisit entities with all the changes.
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        
        Form {
            
            Section(header: Text("Project Name")) {
                Text(project.name ?? "")
            }
            Section(header: Text("Date Created")) {
                Text(project.dateCreated ?? "")
            }
            Section(header: Text("Company Photo")) {
                photoImageFromBinaryData(binaryData: project.photo!.projectPhoto!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
            }
            Section(header: Text("Description")) {
                Text(project.d_escription ?? "")
            }
            Section(header: Text("Technologies")) {
                Text(project.technologies ?? "")
            }
            
        }
    }
}
