//
//  TicketData.swift
//  Agile Suite
//
//  Created by CS3714 on 12/2/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
 
// Global array of tickets found based on database search
var foundTicketsList = [Ticket]()
 
// Array of TicketStruct structs for use only in this file
fileprivate var ticketStructList = [TicketStruct]()
 
/*
 ***********************************
 MARK: - Build Tickets Database
 ***********************************
 */
public func createTicketsDatabase() {
 
    ticketStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: "TicketData.json", fileLocation: "Main Bundle")
   
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
    let fetchRequest = NSFetchRequest<Ticket>(entityName: "Ticket")
    fetchRequest.sortDescriptors = [
        NSSortDescriptor(key: "dueDate", ascending: true),
        NSSortDescriptor(key: "dateCreated", ascending: false)
    ]
   
    var tickets = [Ticket]()
   
    do {
        //-----------------------------
        // ❎ Execute the Fetch Request
        //-----------------------------
        tickets = try managedObjectContext.fetch(fetchRequest)
    } catch {
        print("Populate Database Failed!")
        return
    }
   
    if tickets.count > 0 {
        // Database has already been populated
        print("Database has already been populated!")
        return
    }
   
    print("Database will be populated!")
   
    for aTicketStruct in ticketStructList {
        /*
         =================================================
         Create a Ticket Entity instance and dress it up
         =================================================
         */
        // ❎ Create an instance of the Ticket Entity in CoreData managedObjectContext
        let ticketEntity = Ticket(context: managedObjectContext)
       
        // ❎ Dress it up by specifying its attributes
        ticketEntity.title = aTicketStruct.title
        ticketEntity.d_escription = aTicketStruct.description
        ticketEntity.dueDate = aTicketStruct.dueDate
        ticketEntity.dateCreated = aTicketStruct.dateCreated
        ticketEntity.completed = aTicketStruct.completed as NSNumber?
        
        /*
         ===================================================
         Save Ticket Entity instance to Core Data database
         ===================================================
         */
       
        // ❎ CoreData Save operation
        do {
            try managedObjectContext.save()
        } catch {
            return
        }
       
    }   // End of for loop
   
}   // End of populateDatabase() function
