//
//  Project.swift
//  Agile Suite
//
//  Created by Thuc Phan on 12/3/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//


import Foundation
import CoreData

/*
 🔴 Set Current Product Module:
 In xcdatamodeld editor, select Song, show Data Model Inspector, and
 select Current Product Module from Module menu.
 🔴 Turn off Auto Code Generation:
 In xcdatamodeld editor, select Song, show Data Model Inspector, and
 select Manual/None from Codegen menu.
 */

// ❎ CoreData Project entity public class
public class Project: NSManagedObject, Identifiable {
    
    @NSManaged public var name: String?
    @NSManaged public var dateCreated: String?
    @NSManaged public var d_escription: String?
    @NSManaged public var technologies: String?
    @NSManaged public var company: String?
//    @NSManaged public var audio: Audio?
    @NSManaged public var photo: Photo?
}

extension Project {
    /*
     ❎ CoreData @FetchRequest in SongsList.swift invokes this Song class method
     to fetch all of the Song entities from the database.
     The 'static' keyword designates the func as a class method invoked by using the
     class name as Song.allSongsFetchRequest() in any .swift file in your project.
     */
    static func allProjectsFetchRequest() -> NSFetchRequest<Project> {
        
        let request: NSFetchRequest<Project> = Project.fetchRequest() as! NSFetchRequest<Project>
        /*
         List the trips in alphabetical order with respect to artistName;
         If artistName is the same, then sort with respect to songName.
         */
        request.sortDescriptors = [
            // Primary sort key: artistName
            NSSortDescriptor(key: "name", ascending: true),
            // Secondary sort key: songName
            NSSortDescriptor(key: "dateCreated", ascending: true)
        ]
        
        return request
    }
    
    /*
     ❎ CoreData @FetchRequest in SearchDatabase.swift invokes this Song class method
     to fetch filtered Song entities from the database for the given search query.
     The 'static' keyword designates the func as a class method invoked by using the
     class name as Song.filteredSongsFetchRequest() in any .swift file in your project.
     */
    static func filteredProjectsFetchRequest(searchCategory: String, searchQuery: String) -> NSFetchRequest<Project> {
        
        let fetchRequest = NSFetchRequest<Project>(entityName: "Project")
        
        /*
         List the found songs in alphabetical order with respect to artistName;
         If artistName is the same, then sort with respect to songName.
         */
        fetchRequest.sortDescriptors = [
            // Primary sort key: artistName
            NSSortDescriptor(key: "name", ascending: true),
            // Secondary sort key: songName
            NSSortDescriptor(key: "dateCreated", ascending: true)
        ]
        
        // Case insensitive search [c] for searchQuery under each category
        switch searchCategory {
        case "Project Name":
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS[c] %@", searchQuery)
        case "Company Name":
            fetchRequest.predicate = NSPredicate(format: "company CONTAINS[c] %@", searchQuery)
        case "Project Technologies":
            fetchRequest.predicate = NSPredicate(format: "technologies CONTAINS[c] %@", searchQuery)
        case "Project Description":
            fetchRequest.predicate = NSPredicate(format: "d_escription CONTAINS[c] %@", searchQuery)
        case "All":
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS[c] %@ OR company CONTAINS[c] %@ OR technologies CONTAINS[c] %@ d_escription CONTAINS[c] %@ ", searchQuery, searchQuery, searchQuery, searchQuery)
        default:
            print("Search category is out of range")
        }
        
        return fetchRequest
    }
}
