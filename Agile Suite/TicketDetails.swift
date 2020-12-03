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
                if (ticket.completed! as! Bool) {
                    Text("Yes")
                }
                else {
                    Text("No")
                }
            }
            Section(header: Text("Ticket Date Created")) {
                Text(ticket.dateCreated!)
            }
        }   // End of Form
        .font(.system(size: 14))
        .navigationBarTitle(Text("To-Do Task Details"), displayMode: .inline)
    }
}
