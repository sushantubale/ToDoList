//
//  MessagesView.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 8/12/20.
//

import SwiftUI

struct MessagesView: View {
    var body: some View {
        TabItem(imageName: "envelope", tag: 1, tabTitle: "Messages")
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
