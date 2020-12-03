//
//  ContentView.swift
//  Agile Suite
//
//  Created by CS3714 on 11/15/20.
//

import Foundation
import SwiftUI

struct ContentView : View {
   
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
   
    var body: some View {
        if userData.userAuthenticated {
            return AnyView(MainView())
        } else {
            return AnyView(LoginView())
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
