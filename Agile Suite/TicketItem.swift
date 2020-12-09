//
//  TicketItem.swift
//  Agile Suite
//
//  Created by CS3714 on 12/2/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI
 
struct TicketItem: View {
   
    // Input Parameter
    let ticket: Ticket
   
    
    var body: some View {
        HStack {
            // This public function is given in UtilityFunctions.swift
            if (ticket.completed! as! Bool) {
                Image(systemName: "checkmark.square")
                    .imageScale(.large)
                    .font(Font.title.weight(.regular))
                    .foregroundColor(.blue)
            }
            else {
                Image(systemName: "square")
                    .imageScale(.large)
                    .font(Font.title.weight(.regular))
                    .foregroundColor(.blue)
            }
           
            itemContents
            // Set font and size for the whole VStack content
            .font(.system(size: 14))
           
        }   // End of HStack
    }
    
    var itemContents: AnyView {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let ticketDueDate = dateFormatter.date(from: ticket.dueDate!)
        if (Date() > ticketDueDate!) {
            return AnyView(
                    VStack(alignment: .leading) {
                    Text(ticket.title!)
                        .foregroundColor(Color.red)
                    Text(ticket.dueDate!)
                        .foregroundColor(Color.red)
                }
            )
        }
        return AnyView(
                VStack(alignment: .leading) {
                Text(ticket.title!)
                    .foregroundColor(Color.green)
                Text(ticket.dueDate!)
                    .foregroundColor(Color.green)
            }
        )
    }
}
