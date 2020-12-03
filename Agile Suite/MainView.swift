//
//  MainView.swift
//  Agile Suite
//
//  Created by Thuc Phan on 12/3/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            NonWork()
                .tabItem {
                    Image(systemName: "paperplane")
                    Text("Break")
                }
            TicketsList()
                .tabItem {
                    Image(systemName: "ticket")
                    Text("Tickets")
                }
            Settings()
                .tabItem {
                    Image(systemName: "gear")
                    SwiftUI.Text("Settings")
                }
        }   // End of TabView
            .font(.headline)
            .imageScale(.medium)
            .font(Font.title.weight(.regular))    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
