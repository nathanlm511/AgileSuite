//
//  TicketDetails.swift
//  Agile Suite
//
//  Created by CS3714 on 12/2/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
 
struct TicketDetails: View {
    
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // ❎ Refresh this view upon notification that the managedObjectContext completed a save.
    // Upon refresh, @FetchRequest is re-executed fetching all Ticket entities with all the changes.
    @EnvironmentObject var userData: UserData
    
    @State private var toggleCompletion = false
   
    // Input Parameter
    let ticket: Ticket
   
    var body: some View {
        Form {
            Section(header: Text("Ticket Title")) {
                Text(ticket.title!)
            }
            Section(header: Text("Ticket Description")) {
                Text(ticket.d_escription!)
            }
            Section(header: Text("Ticket Due Date")) {
                Text(ticket.dueDate!)
            }
            Section(header: Text("Ticket Completion")) {
                if (toggleCompletion) {
                    if (ticket.completed! as! Bool) {
                        Text("Yes")
                    }
                    else {
                        Text("No")
                    }
                }
                else {
                    if (ticket.completed! as! Bool) {
                        Text("Yes")
                    }
                    else {
                        Text("No")
                    }
                }
            }
            Section(header: Text("Ticket Date Created")) {
                Text(ticket.dateCreated!)
            }
            Section(header: Text("Toggle Completion")) {
                Button(action: toggleCompleted) {
                    Text("Toggle Completion")
                        .padding(5)
                        .padding(.horizontal)
                }.background(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(Color.blue, lineWidth: 1)
                )
            }
        }   // End of Form
        .font(.system(size: 14))
        .navigationBarTitle(Text("To-Do Task Details"), displayMode: .inline)
    }
    
    func toggleCompleted() {
        var currentCompleted = ticket.completed!
        if (currentCompleted == 0) {
            currentCompleted = 1
            toggleCompleted(increment: true)
        }
        else {
            currentCompleted = 0
            toggleCompleted(increment: false)
        }
        ticket.setValue(currentCompleted, forKey: "completed")
        do {
            try self.managedObjectContext.save()
            toggleCompletion = !toggleCompletion
        }
        catch {
            print("Unable to edit ticket completion")
        }
    }
    
    func toggleCompleted(increment: Bool) {
        
        // save to statistics
        let fetchRequestPublisher = NSFetchRequest<Stats>(entityName: "Stats")
        var arr = [Stats]()
        var statsFound = Stats()
        do {
            //-----------------------------
            // ❎ Execute the Fetch Request
            //-----------------------------
            arr = try managedObjectContext.fetch(fetchRequestPublisher)
            statsFound = arr[0]
            let firstWeek = statsFound.firstDate
            let components = Calendar.current.dateComponents([.weekOfYear], from: firstWeek, to: Date())
            let weekDiff = components.weekOfYear
            let length = statsFound.ticketsCompleted.count
            var index = length
            while index <= (weekDiff ?? 0) {
                statsFound.ticketsCompleted.append(0)
                index = index + 1
                
            }
            if (increment) {
                statsFound.ticketsCompleted[weekDiff ?? 0] = statsFound.ticketsCompleted[weekDiff ?? 0] + 1
            }
            else {
                statsFound.ticketsCompleted[weekDiff ?? 0] = statsFound.ticketsCompleted[weekDiff ?? 0] - 1
            }
            
            
        } catch {
            print("Stats entity fetch failed!")
        }
           
    }   // End of function
}
