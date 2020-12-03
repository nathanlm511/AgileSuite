//
//  TicketsList.swift
//  Agile Suite
//
//  Created by CS3714 on 12/2/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI
 
struct TicketsList: View {
    
    // ❎ CoreData FetchRequest returning all Song entities in the database
    @FetchRequest(fetchRequest: Ticket.allTicketsFetchRequest()) var allTickets: FetchedResults<Ticket>
     
    // ❎ Refresh this view upon notification that the managedObjectContext completed a save.
    // Upon refresh, @FetchRequest is re-executed fetching all Song entities with all the changes.
    @EnvironmentObject var userData: UserData
   
    var body: some View {
        NavigationView {
            Form {
                Section {
                    List {
                        ForEach(allTickets) { aTicket in
                            NavigationLink(destination: TicketDetails(ticket: aTicket)) {
                                TicketItem(ticket: aTicket)
                            }
                        }
                    }   // End of List
                        .navigationBarTitle(Text("Tickets Found"), displayMode: .inline)
                }
            }
        }
    }
}
 
struct TicketsList_Preview: PreviewProvider {
    static var previews: some View {
        TicketsList()
    }
}
