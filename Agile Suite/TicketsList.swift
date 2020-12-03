//
//  TicketsList.swift
//  Agile Suite
//
//  Created by CS3714 on 12/2/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
 
struct TicketsList: View {
    
    @State private var refreshId = UUID()
    
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // ❎ CoreData FetchRequest returning all Ticket entities in the database
    @FetchRequest(fetchRequest: Ticket.allTicketsFetchRequest()) var allTickets: FetchedResults<Ticket>
     
    // ❎ Refresh this view upon notification that the managedObjectContext completed a save.
    // Upon refresh, @FetchRequest is re-executed fetching all Ticket entities with all the changes.
    @EnvironmentObject var userData: UserData
   
    var body: some View {
        NavigationView {
            List {
                ForEach(self.allTickets) { aTicket in
                    NavigationLink(destination: TicketDetails(ticket: aTicket)
                                    .onDisappear(perform: {self.refreshId = UUID()})) {
                        TicketItem(ticket: aTicket)
                    }
                }
                .onDelete(perform: delete)
            }   // End of List
                .id(refreshId)
                .navigationBarTitle(Text("Tickets Found"), displayMode: .inline)
                // Place the Edit button on left and Add (+) button on right of the navigation bar
                .navigationBarItems(leading: EditButton(), trailing:
                    NavigationLink(destination: AddTicket()) {
                        Image(systemName: "plus")
                    })
        }
    }
    
    /*
     ----------------------------------
     MARK: - Delete Selected Tickets
     ----------------------------------
     */
    func delete(at offsets: IndexSet) {
        /*
        'offsets.first' is an unsafe pointer to the index number of the array element
        to be deleted. It is nil if the array is empty. Process it as an optional.
        */
        if let index = offsets.first {
           
            let ticketEntityToDelete = self.allTickets[index]
           
            // ❎ CoreData Delete operation
            self.managedObjectContext.delete(ticketEntityToDelete)
           
            // ❎ CoreData Save operation
            do {
                try self.managedObjectContext.save()
            } catch {
                print("Unable to delete!")
            }
        }
    }
}
 
struct TicketsList_Preview: PreviewProvider {
    static var previews: some View {
        TicketsList()
    }
}
