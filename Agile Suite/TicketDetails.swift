//
//  TicketDetails.swift
//  Agile Suite
//
//  Created by CS3714 on 12/2/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI
 
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
            Section(header: Text("Toggle Completed")) {
                Button(action: toggleCompleted) {
                    Text("Toggle Completed")
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
        }
        else {
            currentCompleted = 0
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
}
