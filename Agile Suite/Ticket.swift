//
//  Ticket.swift
//  Agile Suite
//
//  Created by CS3714 on 12/2/20.
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
public class Ticket: NSManagedObject, Identifiable {
    
    @NSManaged public var title: String?
    @NSManaged public var d_escription: String?
    @NSManaged public var dueDate: String?
    @NSManaged public var dateCreated: String?
    @NSManaged public var completed: NSNumber?
}
 
/*
 Swift type Double cannot be used for @NSManaged Core Data attributes because the type
 Double cannot be represented in Objective-C, which is internally used for Core Data.
 Therefore, we must use the Objective-C type NSNumber instead for latitude and longitude.
 */
 
extension Ticket {
   
    static func allTicketsFetchRequest() -> NSFetchRequest<Ticket> {
       
        let request: NSFetchRequest<Ticket> = Ticket.fetchRequest() as! NSFetchRequest<Ticket>
        request.sortDescriptors = [
            NSSortDescriptor(key: "dueDate", ascending: true),
            NSSortDescriptor(key: "dateCreated", ascending: true)
        ]
        return request
    } 
}
