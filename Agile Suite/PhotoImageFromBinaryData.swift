//
//  PhotoImageFromBinaryData.swift
//  Agile Suite
//
//  Created by Thuc Phan on 12/7/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI
 
/*
*************************************************
|   Return Photo Image from Given Binary Data   |
*************************************************
*/
public func photoImageFromBinaryData(binaryData: Data?) -> Image {
 
    // Create a UIImage object from binaryData
    let uiImage = UIImage(data: binaryData!)
  
    // Unwrap uiImage to see if it has a value
    if let imageObtained = uiImage {
      
        // Image is successfully obtained
        return Image(uiImage: imageObtained)
      
    } else {
        return Image("ImageUnavailable")
    }
  
}
