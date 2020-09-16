//
//  ToDoListApp.swift
//  Shared
//
//  Created by Sushant-Old on 8/12/20.
//

import SwiftUI

@main
struct ToDoListApp: App {
    @State private var hasOnboarded = false

    var body: some Scene {
           WindowGroup {
               if hasOnboarded {
                   ContentView()
                       .onAppear(perform: checkOnboarding)
               } else {
                   MessagesView()
                       .onAppear(perform: checkOnboarding)
               }
           }
       }
    
    func checkOnboarding() {
        // Login flow
        // Login authenticated, hasOnboarded = truee
    }

}
