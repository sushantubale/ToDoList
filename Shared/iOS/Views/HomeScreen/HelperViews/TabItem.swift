//
//  TabItem.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 8/12/20.
//

import SwiftUI


struct TabItem: View {
    
    let imageName: String
    let tag: Int
    let tabTitle: String
    
    init(imageName: String, tag: Int, tabTitle: String) {
        self.imageName = imageName
        self.tag = tag
        self.tabTitle = tabTitle
    }
    
    var body: some View {
        Text(tabTitle)
        .tabItem {
            Image(systemName: imageName)
            Text(tabTitle)
        }.tag(tag)
    }
}

struct TabItem_Previews: PreviewProvider {
    static var previews: some View {
        TabItem(imageName: "gauge", tag: 0, tabTitle: "Dashboard")
    }
}
