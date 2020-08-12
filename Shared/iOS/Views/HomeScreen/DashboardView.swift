//
//  DashboardView.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 8/12/20.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        TabItem(imageName: "gauge", tag: 0, tabTitle: "Dashboard")
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
