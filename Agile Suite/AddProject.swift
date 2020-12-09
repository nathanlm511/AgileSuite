//
//  AddProject.swift
//  Agile Suite
//
//  Created by Thuc Phan on 12/7/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
import CoreLocation


struct AddProject: View {
    
    /*
     Display this view as a Modal View and enable it to dismiss itself
     to go back to the previous view in the navigation hierarchy.
     */
    @Environment(\.presentationMode) var presentationMode
   
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var showProjectAddedAlert = false
    @State private var showInputDataMissingAlert = false
    
    // Project Entity
    @State private var name = ""
    @State private var dateCreated = Date()
    @State private var d_escription = ""
    @State private var technologies = ""
    @State private var company = ""
    
    // Projects Photo picker
    @State private var showImagePicker = false
    @State private var photoImageData: Data? = nil
    @State private var photoTakeOrPickIndex = 1     // Default: Take using camera
    let photoTakeOrPickChoices = ["Camera", "Photo Library"]
    
    // Set the date created
    var dateClosedRange: ClosedRange<Date> {
        // Set minimum date to 20 years earlier than the current year
        let minDate = Calendar.current.date(byAdding: .year, value: -20, to: Date())!
       
        // Set maximum date to 2 years later than the current year
        let maxDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())!
        return minDate...maxDate
    }

    
    
    var body: some View {
        
        Form {
            
            Section(header: Text("Project Name")) {
                HStack {
                    TextField("Enter Project Name", text: $name)
                    Button(action: {
                        self.name = ""
                    }) {
                        Image(systemName: "clear")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                    }
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .autocapitalization(.words)
            }
            Section(header: Text("Company Name")) {
                HStack {
                    TextField("Enter Company Name", text: $company)
                    Button(action: {
                        self.company = ""
                    }) {
                        Image(systemName: "clear")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                    }
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disableAutocorrection(true)
                .autocapitalization(.words)
            }
            Section(header: Text("Company Photo")) {
                projectPhotoImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100.0, height: 100.0)
                Spacer()
            }
            Section(header: Text("Add Company Photo")) {
                VStack {
                    Picker("Take or Pick Photo", selection: $photoTakeOrPickIndex) {
                        ForEach(0 ..< photoTakeOrPickChoices.count, id: \.self) {
                            Text(self.photoTakeOrPickChoices[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    Button(action: {
                        self.showImagePicker = true
                    }) {
                        Text("Get Photo")
                            .padding()
                    }
                }   // End of VStack
            }
            .alert(isPresented: $showProjectAddedAlert, content: { self.projectAddedAlert })
            Section(header: Text("Project Creation Date")) {
                DatePicker(
                    selection: $dateCreated,
                    in: dateClosedRange,
                    displayedComponents: .date) {
                        Text("Creation date")
                    }
            }
            Section(header: Text("Project Description"), footer:
                        Button(action: {
                            self.dismissKeyboard()
                        }) {
                            Image(systemName: "keyboard")
                                .font(Font.title.weight(.light))
                                .foregroundColor(.blue)
                        }
            ) {
                TextEditor(text: $d_escription)
                    .frame(height: 100)
                    .font(.custom("Helvetica", size: 14))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
            }
            Section(header: Text("Technologies Used"), footer:
                        Button(action: {
                            self.dismissKeyboard()
                        }) {
                            Image(systemName: "keyboard")
                                .font(Font.title.weight(.light))
                                .foregroundColor(.blue)
                        }
            ) {
                TextEditor(text: $technologies)
                    .frame(height: 100)
                    .font(.custom("Helvetica", size: 14))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
            }
        }
        .font(.system(size: 14))
        .alert(isPresented: $showInputDataMissingAlert, content: { self.inputDataMissingAlert })
        .navigationBarTitle(Text("Add Project"), displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                if self.inputDataValidated() {
                    self.saveNewProject()
                    self.showProjectAddedAlert = true
                } else {
                    self.showInputDataMissingAlert = true
                }
            }) {
                Text("Save")
            })
        .sheet(isPresented: self.$showImagePicker) {
            /*
             🔴 We pass $showImagePicker and $photoImageData with $ sign into PhotoCaptureView
             so that PhotoCaptureView can change them. The @Binding keywork in PhotoCaptureView
             indicates that the input parameter is passed by reference and is changeable (mutable).
             */
            PhotoCaptureView(showImagePicker: self.$showImagePicker,
                             photoImageData: self.$photoImageData,
                             cameraOrLibrary: self.photoTakeOrPickChoices[self.photoTakeOrPickIndex])
        }

    } // end of body
    
    /*
    ---------------------------------
    MARK: - Project Photo
    ---------------------------------
    */
    var projectPhotoImage: Image {
       
        if let imageData = self.photoImageData {
            let photo = photoImageFromBinaryData(binaryData: imageData)
            return photo
        } else {
            return Image("ImageUnavailable")
        }
    }
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var inputDataMissingAlert: Alert {
        Alert(title: Text("Missing Input Data!"),
              message: Text("Required Data: Project Name, Project Description"),
              dismissButton: .default(Text("OK")) )
    }
    /*
     -----------------------------
     MARK: - Input Data Validation
     -----------------------------
     */
    func inputDataValidated() -> Bool {
 
        if self.name.isEmpty  {
            return false
        }
       
        return true
    }
    /*
     ------------------------
     MARK: - Project Added Alert
     ------------------------
     */
    var projectAddedAlert: Alert {
        Alert(title: Text("Project Added!"),
              message: Text("New Project is added to your database."),
              dismissButton: .default(Text("OK")) {
                  // Dismiss this View and go back
                  self.presentationMode.wrappedValue.dismiss()
            })
    }
    /*
     ---------------------
     MARK: - Save New Project
     ---------------------
     */
    func saveNewProject() {
       
        // Instantiate a DateFormatter object
        let dateFormatter = DateFormatter()
       
        // Set the date format to yyyy-MM-dd
        dateFormatter.dateFormat = "yyyy-MM-dd"
       
        // Obtain DatePicker's selected date, format it as yyyy-MM-dd, and convert it to String
        let releaseDateString = dateFormatter.string(from: self.dateCreated)
       
        /*
         =====================================================
         Create an instance of the Song Entity and dress it up
         =====================================================
        */
       
        // ❎ Create a new Song entity in CoreData managedObjectContext
        let newProject = Project(context: self.managedObjectContext)
       
        // ❎ Dress up the new Song entity
        newProject.name = self.name
        newProject.dateCreated = releaseDateString
        newProject.d_escription = self.d_escription
        newProject.technologies = self.technologies
        newProject.company = self.company
       
        /*
         ======================================================
         Create an instance of the Photo Entity and dress it up
         ======================================================
        */
       
        // ❎ Create a new Photo entity in CoreData managedObjectContext
        let newPhoto = Photo(context: self.managedObjectContext)
       
        // ❎ Dress up the new Photo entity
        if let imageData = self.photoImageData {
            newPhoto.projectPhoto = imageData
        } else {
            // Obtain the album cover default image from Assets.xcassets as UIImage
            let photoUIImage = UIImage(named: "ImageUnavailable")
           
            // Convert photoUIImage to data of type Data (Binary Data) in JPEG format with 100% quality
            let photoData = photoUIImage?.jpegData(compressionQuality: 1.0)
           
            // Assign photoData to Core Data entity attribute of type Data (Binary Data)
            newPhoto.projectPhoto = photoData!
        }
       
        /*
         ==============================
         Establish Entity Relationships
         ==============================
        */
       
        // Establish One-to-One Relationship between Song and Photo
        newProject.photo = newPhoto
        newPhoto.project = newProject
       
        /*
         =============================================
         MARK: - ❎ Save Changes to Core Data Database
         =============================================
         */
       
        do {
            try self.managedObjectContext.save()
        } catch {
            return
        }
       
    }   // End of function
}
