//
//  TasksView.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 8/12/20.
//

import SwiftUI

struct TasksView: View {
    @State private var searchText : String = ""
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                ScrollView(.vertical, showsIndicators: true, content: {
                    
                    VStack(spacing: 20) {
                        
                        VStack {
                            SearchBar(text: $searchText)
                        }
                        
                        HStack(spacing: 60) {
                            NavigationLink(destination: Text("Details View")) {
                                ButtonView(title: "Inbox", imageName: "tray.and.arrow.down", backgroundColor: Color.green)
                                    .frame(width: 150, height: 100)
                            }
                            
                            NavigationLink(destination: Text("Details View")) {
                                ButtonView(title: "Inbox", imageName: "tray.and.arrow.down", backgroundColor: Color.red)
                                    .frame(width: 150, height: 100)
                            }
                            
                        }
                        HStack(spacing: 60) {
                            NavigationLink(destination: Text("Details View")) {
                                ButtonView(title: "Inbox", imageName: "tray.and.arrow.down", backgroundColor: Color.blue)
                                    .frame(width: 150, height: 100)
                            }
                            
                            NavigationLink(destination: Text("Details View")) {
                                ButtonView(title: "Inbox", imageName: "tray.and.arrow.down", backgroundColor: Color.orange)
                                    .frame(width: 150, height: 100)
                            }
                        }
                        Spacer()
                    }
//                    .frame(width: geo.size.width, height: geo.size.height/2, alignment: .center)

                    ListViewWithHeader(listData: [
                        ListData(headerTitle: "SENDERS", rows: ["Threat Response","Training","Vulnerability Management"]),
                        ListData(headerTitle: "STATE", rows: ["Pending Acceptance","Assigned","Copied", "Pending Acceptance","Assigned","Copied"])
                    ])
                    .frame(width: geo.size.width, height: geo.size.height/2, alignment: .center)
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
        .tabItem {
            Image(systemName: "checkmark.shield")
            Text("Tasks")
        }.tag(2)

    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
