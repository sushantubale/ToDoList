//
//  TasksView.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 8/12/20.
//

import SwiftUI

struct TasksView: View, ViewLifeCycle {
    @State private var searchText : String = ""
    @ObservedObject var taskViewModel: TasksViewModel = TasksViewModel()
    var activityIndicator = ActivityIndicatorView()
    @State var didAppear = false
    @State var appearCount = 0
    
    var body: some View {
        
        NavigationView {
            GeometryReader { geometryReader in
                
                if taskViewModel.showActivityIndicator == true {
                    VStack {
                        activityIndicator
                            .frame(width: geometryReader.size.width, height: geometryReader.size.width)
                            .foregroundColor(.orange)
                    }
                } else {
                    ScrollView(.vertical, showsIndicators: true, content: {
                        
                        VStack(alignment: .center, spacing: 10) {
                            VStack {
                                SearchBar(text: searchText)
                                ForEach(0..<2) { i in
                                    HStack(spacing: geometryReader.size.width/8) {
                                        ForEach(0..<2) { j in
                                            CollectionViewCell(row: 2, column: 2)
                                        }
                                    }
                                }
                                ListViewWithHeader(listData: [
                                    ListData(headerTitle: "SENDERS", rows: taskViewModel.taskTypes),
                                    ListData(headerTitle: "STATE", rows: taskViewModel.taskTypes)
                                ])
                                .frame(minWidth: geometryReader.size.width, maxWidth: .infinity, minHeight: geometryReader.size.height/2, maxHeight: .infinity, alignment: .center)
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    })
                    .navigationTitle(Constants.Tasks.headerTitle)
                    .navigationBarItems(trailing:
                                            Button(action: {
                                                print("Edit button pressed ")
                                            }) {
                                                Image(systemName: Constants.ImageNames.gear)
                                            })
                }
            }
        }
        .phoneOnlyNavigationView()
        .tabItem {
            Image(systemName: Constants.ImageNames.checkmarkShield)
            Text("Tasks")
        }.tag(2)
        .onAppear(perform: onLoad)
        .onDisappear(perform: onUnload)
    }
    
    func onUnload() {
        print("onUnload called")
    }
    
    func onLoad() {
        if didAppear == false {
            appearCount += 1
            taskViewModel.getTasksData()
        }
        didAppear = true
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
            .previewDevice(PreviewDevice(rawValue: "iPad (7th generation)"))
        TasksView()
    }
}

extension View {
    func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)

        }
    }
}
