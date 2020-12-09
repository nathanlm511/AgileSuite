//
//  AddTicket.swift
//  Agile Suite
//
//  Created by CS3714 on 12/2/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
 
struct AddTicket: View {
   
    /*
     Display this view as a Modal View and enable it to dismiss itself
     to go back to the previous view in the navigation hierarchy.
     */
    @Environment(\.presentationMode) var presentationMode
   
    // ❎ CoreData managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
   
    // Ticket Entity
    @State private var title = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @State private var completed = false
    
    // Alerts
    @State private var showTicketSavedAlert = false
    @State private var showInputDataMissingAlert = false
   
    var dateClosedRange: ClosedRange<Date> {
        // Set minimum date to 20 years earlier than the current year
        let minDate = Calendar.current.date(byAdding: .year, value: -20, to: Date())!
       
        // Set maximum date to 2 years later than the current year
        let maxDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())!
        return minDate...maxDate
    }
   
    var body: some View {
        Form {
            Section(header: Text("Ticket Title")) {
                TextField("Enter a title for your ticket", text: $title)
            }
            Section(header: Text("Ticket Description"), footer:
                        Button(action: {
                                self.dismissKeyboard()
                            }) {
                                Image(systemName: "keyboard")
                                    .font(Font.title.weight(.light))
                                    .foregroundColor(.blue)
                            }) {
                TextEditor(text: $description)
                    .frame(height: 100)
                    .font(.custom("Helvetica", size: 14))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
            }
            Section(header: Text("Ticket Due Date")) {
                DatePicker(
                    selection: $dueDate,
                    in: dateClosedRange,
                    displayedComponents: .date) {
                        Text("Ticket Due Date")
                    }
            }
            .alert(isPresented: $showTicketSavedAlert, content: { self.ticketSavedAlert })
           
        }   // End of Form
            .font(.system(size: 14))
            .disableAutocorrection(true)
            .autocapitalization(.words)
            .navigationBarTitle(Text("Add Ticket"), displayMode: .inline)
            // Use single column navigation view for iPhone and iPad
            .navigationViewStyle(StackNavigationViewStyle())
            .alert(isPresented: $showInputDataMissingAlert, content: { self.inputDataMissingAlert })
            .navigationBarItems(trailing:
                Button(action: {
                    if self.inputDataValidated() {
                        self.saveNewTicket()
                        self.showTicketSavedAlert = true
                    } else {
                        self.showInputDataMissingAlert = true
                    }
                }) {
                    Text("Save")
            })
       
    }   // End of body
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
   
    /*
    ------------------------------
    MARK: - Ticket  Saved Alert
    ------------------------------
    */
    var ticketSavedAlert: Alert {
        Alert(title: Text("New Ticket Saved!"),
              message: Text("Your new ticket is successfully saved in the database!"),
              dismissButton: .default(Text("OK")) {
               
                // Dismiss this Modal View and go back to the previous view in the navigation hierarchy
                self.presentationMode.wrappedValue.dismiss()
            })
    }
   
    /*
     --------------------------------
     MARK: - Input Data Missing Alert
     --------------------------------
     */
    var inputDataMissingAlert: Alert {
        Alert(title: Text("Missing Input Data!"),
              message: Text("Required Data: Ticket Title and Ticket Notes."),
              dismissButton: .default(Text("OK")) )
    }
   
    /*
     -----------------------------
     MARK: - Input Data Validation
     -----------------------------
     */
    func inputDataValidated() -> Bool {
       
        if self.title.isEmpty || self.description.isEmpty {
            return false
        }
       
        return true
    }
   
    /*
     ************************************
     MARK: - Save New Ticket
     ************************************
     */
    func saveNewTicket() {
       
        // Instantiate a DateFormatter object
        let dateFormatter = DateFormatter()
       
        // Set the date format to yyyy-MM-dd
        dateFormatter.dateFormat = "yyyy-MM-dd"
       
        // Obtain DatePicker's selected date, format it as yyyy-MM-dd, and convert it to String
        let dueDateStr = dateFormatter.string(from: self.dueDate)
       
        /*
         ==========================================================
         Create an instance of the Ticket Entity and dress it up
         ==========================================================
         */
        // ❎ Create an instance of the Ticket Entity in CoreData managedObjectContext
        let aTicket = Ticket(context: self.managedObjectContext)
       
        // ❎ Dress it up by specifying its attributes
        aTicket.title = title
        aTicket.d_escription = description
        aTicket.dueDate = dueDateStr
        aTicket.completed = completed as NSNumber
       
        //-----------------------------------------------------------
        // Obtain Current Date and Time as "yyyy-MM-dd' at 'HH:mm:ss"
        //-----------------------------------------------------------
        let dateAndTime = Date()
       
        // Create an instance of DateFormatter
        let dateTimeFormatter = DateFormatter()
       
        // Set the date format to yyyy-MM-dd at HH:mm:ss
        dateTimeFormatter.dateFormat = "yyyy-MM-dd' at 'HH:mm:ss"
       
        // Format dateAndTime under the dateTimeFormatter and convert it to String
        let currentDateTime = dateTimeFormatter.string(from: dateAndTime)
       
        aTicket.dateCreated = currentDateTime
        /*
         ==================================
         Save Changes to Core Data Database
         ==================================
         */
       
        // ❎ CoreData Save operation
        do {
            try self.managedObjectContext.save()
        } catch {
            return
        }
        
        // save to statistics
        let fetchRequestPublisher = NSFetchRequest<Stats>(entityName: "Stats")
        var arr = [Stats]()
        var statsFound = Stats()
        do {
            //-----------------------------
            // ❎ Execute the Fetch Request
            //-----------------------------
            arr = try managedObjectContext.fetch(fetchRequestPublisher)
            statsFound = arr[0]
            // if not tickets are set yet, add current date
            if (statsFound.ticketsCreated.count == 0) {
                statsFound.ticketsCreated.append(1)
                statsFound.firstDate = Date().startOfWeek()
            }
            else {
                let firstWeek = statsFound.firstDate
                let components = Calendar.current.dateComponents([.weekOfYear], from: firstWeek, to: Date())
                let weekDiff = components.weekOfYear
                let length = statsFound.ticketsCreated.count
                var index = length
                while index <= (weekDiff ?? 0) {
                    statsFound.ticketsCreated.append(0)
                    index = index + 1
                    
                }
                statsFound.ticketsCreated[weekDiff ?? 0] = statsFound.ticketsCreated[weekDiff ?? 0] + 1
            }
            
        } catch {
            print("Stats entity fetch failed!")
        }
           
    }   // End of function
   
}
 
struct AddTicket_Previews: PreviewProvider {
    static var previews: some View {
        AddTicket()
    }
}

extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
}

extension Date {
    func startOfWeek(using calendar: Calendar = .gregorian) -> Date {
        calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
    }
}
