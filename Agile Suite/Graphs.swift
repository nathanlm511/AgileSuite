//
//  Graphs.swift
//  Agile Suite
//
//  Created by CS3714 on 12/5/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct Graphs: View {
    
    
    // ❎ CoreData FetchRequest returning all Stats entities in the database
    @FetchRequest(fetchRequest: Stats.allStatsFetchRequest()) var allStats: FetchedResults<Stats>
    
    var body: some View {
        ZStack {
            VStack {
                dateText
                LineView(data: allStats[0].ticketsCreated, title: "Weekly Tickets Created ")
                LineView(data: allStats[0].ticketsCompleted, title: "Weekly Tickets Completed")
            }
        }
        
    }
    
    var dateText: AnyView {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy/MM/dd"
        let firstDateAdded = dateFormatter.string(from: allStats[0].firstDate)
        return AnyView(
            Text("First week starts at date: \(firstDateAdded)")
        )
    }
}
