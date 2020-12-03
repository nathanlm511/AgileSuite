//
//  TicketStruct.swift
//  Agile Suite
//
//  Created by CS3714 on 12/2/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI
 
struct TicketStruct: Hashable, Codable {
    
    var title: String
    var description: String
    var dueDate: String
    var dateCreated: String
    var completed: Bool
}
 
/*
 {
     "title": "Add button to front end",
     "description": "Create a new react component that is a red button",
     "dueDate": "2019-10-01",
     "dateCreated": "2019-10-04"
     "completed": false
 }
 */
