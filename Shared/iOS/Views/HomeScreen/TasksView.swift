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
    @State private var numbers = [1,2,3,4,5,6,7,8,9]
    
    var body: some View {
        
        NavigationView {
            GeometryReader { g in
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    HStack(alignment: .center, spacing: 20) {
                        
                        NavigationLink(destination: Text("Hi")) {
                            
                            Button(action: {}, label: {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: Constants.ImageNames.trayArrowDown)
                                            .padding()
                                        Spacer()
                                        Text("2")
                                            .padding()
                                        
                                    }
                                    Text("Inbox")
                                        .padding()
                                }
                                
                            })
                            
                        }
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.purple, lineWidth: 2))
                        
                        NavigationLink(destination: Text("Hi")) {
                            
                            Button(action: {}, label: {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: Constants.ImageNames.trayArrowDown)
                                            .padding()
                                        Spacer()
                                        Text("2")
                                            .padding()
                                        
                                    }
                                    Text("Inbox")
                                        .padding()
                                }
                                
                            })
                            
                        }
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.purple, lineWidth: 2))
                    }
                    .padding()
                    
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 20) {
                        
                        NavigationLink(destination: Text("Hi")) {
                            
                            Button(action: {}, label: {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: Constants.ImageNames.trayArrowDown)
                                            .padding()
                                        Spacer()
                                        Text("2")
                                            .padding()
                                        
                                    }
                                    Text("Inbox")
                                        .padding()
                                }
                                
                            })
                            
                        }
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.purple, lineWidth: 2))
                        
                        NavigationLink(destination: Text("Hi")) {
                            
                            Button(action: {}, label: {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: Constants.ImageNames.trayArrowDown)
                                            .padding()
                                        Spacer()
                                        Text("2")
                                            .padding()
                                        
                                    }
                                    Text("Inbox")
                                        .padding()
                                }
                            })
                        }
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.purple, lineWidth: 2))
                    }
                    .padding()
                    
                    List(0..<self.numbers.count) { number in
                        NavigationLink(destination: Text("Destination")) {
                            Text("\(number)")
                        }
                        
                    }.frame(width: g.size.width - 5, height: g.size.height - 50, alignment: .center)
                    
                    
                })
            }
            .navigationTitle(Constants.Tasks.headerTitle)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        print("Edit button pressed ")
                                    }) {
                                        Image(systemName: Constants.ImageNames.gear)
                                    })
            
        }
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
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
        
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
