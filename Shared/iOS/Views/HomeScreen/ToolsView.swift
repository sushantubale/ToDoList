//
//  ToolsView.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 8/12/20.
//

import SwiftUI

struct ToolsView: View {
    var body: some View {
        TabItem(imageName: "briefcase", tag: 3, tabTitle: "Tools")
    }
}

struct ToolsView_Previews: PreviewProvider {
    static var previews: some View {
        ToolsView()
    }
}
