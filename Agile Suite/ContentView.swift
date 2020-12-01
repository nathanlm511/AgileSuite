//
//  ContentView.swift
//  Agile Suite
//
//  Created by CS3714 on 11/15/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NonWork()
                .tabItem {
                    Image(systemName: "paperplane")
                    Text("Break")
                }
        }   // End of TabView
            .font(.headline)
            .imageScale(.medium)
            .font(Font.title.weight(.regular))    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
