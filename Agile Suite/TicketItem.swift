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
           
            VStack(alignment: .leading) {
                Text(ticket.title!)
                Text(ticket.dueDate!)
            }
            // Set font and size for the whole VStack content
            .font(.system(size: 14))
           
        }   // End of HStack
    }
}
