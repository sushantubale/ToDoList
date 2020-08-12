//
//  ContentView-New.swift
//  Shared
//
//  Created by Sushant-Old on 8/12/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchText : String = ""

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true, content: {

                VStack(spacing: 20) {
                    
                    VStack {
                        SearchBar(text: $searchText)
                    }
                    
                    HStack(spacing: 60) {
                        ButtonView(title: "Inbox", imageName: "tray.and.arrow.down", backgroundColor: Color.blue)
                            .frame(width: 150, height: 100)
                        
                        ButtonView(title: "Inbox", imageName: "tray.and.arrow.down", backgroundColor: Color.red)
                            .frame(width: 150, height: 100)
                    }
                    HStack(spacing: 60) {
                        ButtonView(title: "Inbox", imageName: "tray.and.arrow.down", backgroundColor: Color.gray)
                            .frame(width: 150, height: 100)
                        
                        ButtonView(title: "Inbox", imageName: "tray.and.arrow.down", backgroundColor: Color.orange)
                            .frame(width: 150, height: 100)
                    }
                    Spacer()
                }
                ListViewWithHeader(listData: [
                    ListData(headerTitle: "SENDERS", rows: ["Threat Response","Training","Vulnerability Management"]),
                    ListData(headerTitle: "STATE", rows: ["Pending Acceptance","Assigned","Copied"])
                ])
                .frame(height: 300)
            })
            .navigationTitle("Tasks")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        print("Edit button pressed...")
                                    }) {
                                        Image(systemName: "gear")
                                    })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
