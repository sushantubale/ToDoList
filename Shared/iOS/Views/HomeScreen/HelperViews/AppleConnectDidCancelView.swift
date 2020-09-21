//
//  AppleConnectDidCancelView.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 9/18/20.
//

import SwiftUI

struct AppleConnectDidCancelView: View {
    @State var showingDetail = false
    var body: some View {
        Button(action: {
            self.showingDetail.toggle()
        }) {
            Text("Show Detail")
        }.sheet(isPresented: $showingDetail) {
            AppleConnectFacadeLayer(storyboard: "Storyboard", VC: "ViewController")
            
        }
    }
}

struct AppleConnectDidCancelView_Previews: PreviewProvider {
    static var previews: some View {
        AppleConnectDidCancelView()
    }
}
