//
//  ResultItem.swift
//  Agile Suite
//
//  Created by Thuc Phan on 12/8/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI

struct ResultItem: View {
    
    // ❎ Input parameter: CoreData Project Entity instance reference
    let project: Project
    
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        HStack {
            // This function is given in PhotoImageFromBinaryData.swift
            photoImageFromBinaryData(binaryData: project.photo!.projectPhoto!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0, height: 60.0)
           
            VStack(alignment: .leading) {
                /*
                 ?? is called nil coalescing operator.
                 IF visit.fullName is not nil THEN
                 unwrap it and return its value
                 ELSE return ""
                 */
                Text(project.name ?? "")
                Text(project.dateCreated ?? "")
                Text(project.company ?? "")
            }
                // Set font and size for the whole VStack content
                .font(.system(size: 14))
        }
    }
}
