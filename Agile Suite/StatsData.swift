//
//  StatsData.swift
//  Agile Suite
//
//  Created by CS3714 on 12/5/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
 
/*
 ***********************************
 MARK: - Build Stats Database
 ***********************************
 */
public func createStatsDatabase() {
   
    // ❎ Get object reference of CoreData managedObjectContext from the persistent container
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    //----------------------------
    // ❎ Define the Fetch Request
    //----------------------------
    let fetchRequest = NSFetchRequest<Stats>(entityName: "Stats")
   
    var stats = [Stats]()
   
    do {
        //-----------------------------
        // ❎ Execute the Fetch Request
        //-----------------------------
        stats = try managedObjectContext.fetch(fetchRequest)
    } catch {
        print("Populate Database Failed!")
        return
    }
   
    if stats.count > 0 {
        // Database has already been populated
        print("Database has already been populated!")
        return
    }
   
    print("Stats Database will be populated!")
   
    /*
     =================================================
     Create a Stats Entity instance and dress it up
     =================================================
     */
    // ❎ Create an instance of the Stats Entity in CoreData managedObjectContext
    let statsEntity = Stats(context: managedObjectContext)
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd"
    statsEntity.firstDate = formatter.date(from: "2020/10/09")!
    
    statsEntity.ticketsCreated = [12, 5, 8, 19, 4]
    statsEntity.ticketsCompleted = [4, 6, 9, 12, 11]
    
    /*
     ===================================================
     Save Stats Entity instance to Core Data database
     ===================================================
     */
   
    // ❎ CoreData Save operation
    do {
        try managedObjectContext.save()
    } catch {
        return
    }
}
