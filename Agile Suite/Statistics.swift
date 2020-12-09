//
//  Statistics.swift
//  Agile Suite
//
//  Created by CS3714 on 12/5/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import CoreData
 
/*
 🔴 Set Current Product Module:
    In xcdatamodeld editor, select Ticket and
    select Current Product Module from Module menu.
 🔴 Turn off Auto Code Generation:
    In xcdatamodeld editor, select Ticket and
    select Manual/None from Codegen menu.
*/
 
// ❎ CoreData Ticket entity public class
public class Stats: NSManagedObject, Identifiable {
    
    @NSManaged public var ticketsCreated: [Double]
    @NSManaged public var ticketsCompleted: [Double]
    @NSManaged public var firstDate: Date
}
 
/*
 Swift type Double cannot be used for @NSManaged Core Data attributes because the type
 Double cannot be represented in Objective-C, which is internally used for Core Data.
 Therefore, we must use the Objective-C type NSNumber instead for latitude and longitude.
 */
 
extension Stats {
   
    static func allStatsFetchRequest() -> NSFetchRequest<Stats> {
       
        let request: NSFetchRequest<Stats> = Stats.fetchRequest() as! NSFetchRequest<Stats>
        request.sortDescriptors = [
            NSSortDescriptor(key: "ticketsCreated", ascending: true)
        ]
        return request
    }
}
