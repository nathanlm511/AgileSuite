//
//  Photo.swift
//  Agile Suite
//
//  Created by Thuc Phan on 12/3/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import CoreData

/*
 🔴 Set Current Product Module:
 In xcdatamodeld editor, select Song, show Data Model Inspector, and
 select Current Product Module from Module menu.
 🔴 Turn off Auto Code Generation:
 In xcdatamodeld editor, select Song, show Data Model Inspector, and
 select Manual/None from Codegen menu.
 */

// ❎ CoreData Photo entity public class
public class Photo: NSManagedObject, Identifiable {
    
    @NSManaged public var projectPhoto: Data?
    @NSManaged public var project: Project?
    
}
