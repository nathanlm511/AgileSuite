//
//  PastProjectsData.swift
//  Agile Suite
//
//  Created by Thuc Phan on 12/3/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//


import Foundation
import SwiftUI
import CoreData

// Array of Travel structs for use only in this file
//fileprivate var travelStructList = [Travel]()
var projectStructList = [PastProject]()

/*
 ***********************************
 MARK: - Create Music Album Database
 ***********************************
 */
public func createTravelDatabase() {
    
    projectStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: "PastProjectsData.json", fileLocation: "Main Bundle")
    
    populateDatabase()
}

/*
 *********************************************
 MARK: - Populate Database If Not Already Done
 *********************************************
 */
func populateDatabase() {
    
    // ❎ Get object reference of CoreData managedObjectContext from the persistent container
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //----------------------------
    // ❎ Define the Fetch Request
    //----------------------------
    let fetchRequest = NSFetchRequest<Project>(entityName: "Project")
    fetchRequest.sortDescriptors = [
        // Primary sort key: rating
        NSSortDescriptor(key: "name", ascending: false),
        // Secondary sort key: title
        NSSortDescriptor(key: "dateCreated", ascending: true)
    ]
    
    var listOfAllProjectEntitiesInDatabase = [Project]()
    
    do {
        //-----------------------------
        // ❎ Execute the Fetch Request
        //-----------------------------
        listOfAllProjectEntitiesInDatabase = try managedObjectContext.fetch(fetchRequest)
    } catch {
        print("Populate Database Failed!")
        return
    }
    
    if listOfAllProjectEntitiesInDatabase.count > 0 {
        // Database has already been populated
        print("Database has already been populated!")
        return
    }
    
    print("Database will be populated!")
    
    for project in projectStructList {
        /*
         =====================================================
         Create an instance of the Project Entity and dress it up
         =====================================================
         */
        
        // ❎ Create an instance of the Project entity in CoreData managedObjectContext
        let projectEntity = Project(context: managedObjectContext)
        
        // ❎ Dress it up by specifying its attributes
        projectEntity.name = project.name
        projectEntity.dateCreated = project.dateCreated
        projectEntity.d_escription = project.d_escription
        projectEntity.technologies = project.technologies
        projectEntity.company = project.company
        
        /*
         ======================================================
         Create an instance of the Photo Entity and dress it up
         ======================================================
         */
        
        // ❎ Create an instance of the Photo Entity in CoreData managedObjectContext
        let photoEntity = Photo(context: managedObjectContext)
        
        // Obtain the album cover photo image from Assets.xcassets as UIImage
        let photoUIImage = UIImage(named: project.projectPhoto)
        
        // Convert photoUIImage to data of type Data (Binary Data) in JPEG format with 100% quality
        let photoData = photoUIImage?.jpegData(compressionQuality: 1.0)
        
        // Assign photoData to Core Data entity attribute of type Data (Binary Data)
        photoEntity.projectPhoto = photoData!
        
        /*
         ======================================================
         Create an instance of the Audio Entity and dress it up
         ======================================================
         */
       
//        // ❎ Create an instance of the Audio Entity in CoreData managedObjectContext
//        let audioEntity = Audio(context: managedObjectContext)
//       
//        // ❎ Dress it up by specifying its attribute
//       
//        // Obtain the URL of the national park visit audio filename from main bundle
//        let audioFileUrl = Bundle.main.url(forResource: project.voiceRecording, withExtension: "wav", subdirectory: "AudioFiles")
//       
//        do {
//            // Try to get the audio file data from audioFileUrl
//            audioEntity.voiceRecording = try Data(contentsOf: audioFileUrl!, options: NSData.ReadingOptions.mappedIfSafe)
//           
//        } catch {
//            fatalError("Project Audio is not found in the main bundle!")
//        }
        
        /*
         ==============================
         Establish Entity Relationships
         ==============================
         */
        
        // ❎ Establish Relationship between entities Project and Photo
        projectEntity.photo = photoEntity
        photoEntity.project = projectEntity
        
//        // ❎ Establish Relationship between entities Project and Audio
//        projectEntity.audio = audioEntity
//        audioEntity.project = projectEntity
        
        /*
         ==================================
         Save Changes to Core Data Database
         ==================================
         */
        
        // ❎ CoreData Save operation
        do {
            try managedObjectContext.save()
        } catch {
            return
        }
        
    }   // End of for loop
    
}
