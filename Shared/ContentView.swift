//
//  ContentView-New.swift
//  Shared
//
//  Created by Sushant-Old on 8/12/20.
//

import SwiftUI

struct ContentView: View {
    

    var body: some View {
        TabView {
            // Dashboard View
            DashboardView()
            
            // Messages View
            MessagesView()
            
            // Tasks View
            TasksView()
            
            // Tools View
            ToolsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
