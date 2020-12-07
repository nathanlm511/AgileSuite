//
//  AddProject.swift
//  Agile Suite
//
//  Created by Thuc Phan on 12/7/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

//import Foundation
//import SwiftUI
//import CoreData
//import CoreLocation
//
//
//struct AddProject: View {
//    
//    /*
//     Display this view as a Modal View and enable it to dismiss itself
//     to go back to the previous view in the navigation hierarchy.
//     */
//    @Environment(\.presentationMode) var presentationMode
//   
//    // ❎ CoreData managedObjectContext reference
//    @Environment(\.managedObjectContext) var managedObjectContext
//    
//    // Projects Photo picker
//    @State private var showImagePicker = false
//    @State private var photoImageData: Data? = nil
//    @State private var photoTakeOrPickIndex = 0     // Default: Take using camera
//    let photoTakeOrPickChoices = ["Camera", "Photo Library"]
//    
//    
//    var body: some View {
//        
//        Form {
//            Section(header: Text("Add Project Photo")) {
//                VStack {
//                    Picker("Take or Pick Photo", selection: $photoTakeOrPickIndex) {
//                        ForEach(0 ..< photoTakeOrPickChoices.count, id: \.self) {
//                            Text(self.photoTakeOrPickChoices[$0])
//                        }
//                    }.pickerStyle(SegmentedPickerStyle())
//                        .padding()
//                   
//                    Button(action: {
//                        self.showImagePicker = true
//                    }) {
//                        Text("Get Photo")
//                            .padding()
//                    }
//                }   // End of VStack
//            }
//            Section(header: Text("Project Photo")) {
//                projectPhotoImage
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 100.0, height: 100.0)
//            }
//        }
//        .sheet(isPresented: self.$showImagePicker) {
//            PhotoCaptureView(showImagePicker: self.$showImagePicker,
//                             photoImageData: self.$photoImageData,
//                             cameraOrLibrary: self.photoTakeOrPickChoices[self.photoTakeOrPickIndex])
//    }
//
//    } // end of body
//    
//    /*
//    ---------------------------------
//    MARK: - National Park Visit Photo
//    ---------------------------------
//    */
//    var projectPhotoImage: Image {
//       
//        if let imageData = self.photoImageData {
//            let photo = photoImageFromBinaryData(binaryData: imageData)
//            return photo
//        } else {
//            return Image("ImageUnavailable")
//        }
//    }
//}
