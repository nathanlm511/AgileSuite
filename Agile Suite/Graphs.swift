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
        VStack {
            LineView(data: allStats[0].ticketsCompleted, title: "Tickets completed per Week")
        }
        
    }
}
