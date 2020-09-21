//
//  MainHomeView.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 9/18/20.
//

import SwiftUI


struct MainHomeView: View {
    
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

struct MainHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainHomeView()
    }
}
