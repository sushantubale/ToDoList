//
//  TasksView.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 8/12/20.
//

import SwiftUI

struct TasksView: View {
    @State private var searchText : String = ""
    @ObservedObject private var taskViewModel: TasksViewModel = TasksViewModel()
    var activityIndicator = ActivityIndicatorView()
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                if taskViewModel.showActivityIndicator == true {
                    VStack {
                        activityIndicator
                            .frame(width: 200, height: 200)
                            .foregroundColor(.orange)
                        }
                } else {
                    ScrollView(.vertical, showsIndicators: true, content: {
                        
                        VStack(spacing: 20) {
                            
                            VStack {
                                SearchBar(text: searchText)
                            }
                            
                            HStack(spacing: 60) {
                                NavigationLink(destination: Text("Details View")) {
                                    ButtonView(title: "Inbox", imageName: Constants.ImageNames.trayArrowDown, backgroundColor: Color.green)
                                        .frame(width: 150, height: 100)
                                }
                                
                                NavigationLink(destination: Text("Details View")) {
                                    ButtonView(title: "Inbox", imageName: Constants.ImageNames.trayArrowDown, backgroundColor: Color.red)
                                        .frame(width: 150, height: 100)
                                }
                                
                            }
                            HStack(spacing: 60) {
                                NavigationLink(destination: Text("Details View")) {
                                    ButtonView(title: "Inbox", imageName: Constants.ImageNames.trayArrowDown, backgroundColor: Color.blue)
                                        .frame(width: 150, height: 100)
                                }
                                
                                NavigationLink(destination: Text("Details View")) {
                                    ButtonView(title: "Inbox", imageName: Constants.ImageNames.trayArrowDown, backgroundColor: Color.orange)
                                        .frame(width: 150, height: 100)
                                }
                            }
                            Spacer()
                        }
    //                    .frame(width: geo.size.width, height: geo.size.height/2, alignment: .center)

                        ListViewWithHeader(listData: [
                            ListData(headerTitle: "SENDERS", rows: taskViewModel.taskTypes),
                            ListData(headerTitle: "STATE", rows: taskViewModel.taskTypes)
                        ])
                        .frame(width: geo.size.width, height: geo.size.height/2, alignment: .center)
                    })
                    .navigationTitle(Constants.Tasks.headerTitle)
                    .navigationBarItems(trailing:
                                            Button(action: {
                                                print("Edit button pressed...")
                                            }) {
                                                Image(systemName: Constants.ImageNames.gear)
                                            })
                }

            }
            .tabItem {
                Image(systemName: Constants.ImageNames.checkmarkShield)
                Text("Tasks")
            }.tag(2)


                }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
