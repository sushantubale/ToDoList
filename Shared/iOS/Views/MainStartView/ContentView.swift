//
//  ContentView-New.swift
//  Shared
//
//  Created by Sushant-Old on 8/12/20.
//

import SwiftUI
import AppleConnectClient

struct ContentView: View {

    var body: some View {
        AppleConnectFacadeLayer(storyboard: "Storyboard", VC: "ViewController")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
