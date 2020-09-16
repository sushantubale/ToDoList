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
    private var activityIndicator = ActivityIndicatorView()
    @State var didAppear = false
        
    var body: some View {
        NavigationView {
            GeometryReader { geometryReader in
                if self.taskViewModel.showActivityIndicator == true {
                    HStack {
                         Spacer()
                        activityIndicator
                            .frame(width: 100, height: 100, alignment: .center)
                            .foregroundColor(.gray)
                         Spacer()
                    }
                } else if self.taskViewModel.showActivityIndicator == false {
                    
                    ScrollView(.vertical, showsIndicators: false, content: {
                        SearchBar(text: $searchText)

                            .navigationTitle(Constants.Tasks.headerTitle)
                        HStack(alignment: .center, spacing: 20) {
                            
                            NavigationLink(destination: Text("Hi")) {
                                
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
                            }
                            .frame(maxWidth: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.purple, lineWidth: 2))

                            NavigationLink(destination: Text("Hi")) {
                                
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
                            }
                            .frame(maxWidth: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.purple, lineWidth: 2))

                            NavigationLink(destination: Text("Hi")) {
                                
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
                            }
                            .frame(maxWidth: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.purple, lineWidth: 2))
                        }
                        .padding()
                        
                        List {
                            Section(header: Text("STATE")) {

                                ForEach(self.taskViewModel.dummyTaskData.keys.sorted(), id: \.self) { key in
                                    NavigationLink(
                                        destination: Text("Destination"),
                                        label: {
                                            HStack {
                                                Image(systemName: Constants.ImageNames.checkmarkShield)
                                                    .renderingMode(.template)
                                                    .foregroundColor(.blue)
                                                Text("\(key)")
                                                    .font(.title3)
                                                Spacer()
                                                Text("\(self.taskViewModel.dummyTaskData[key] ?? 0)")
                                                    .foregroundColor(.white)
                                                    .fixedSize(horizontal: false, vertical: true)
                                                    .multilineTextAlignment(.center)
                                                    .padding()
                                                    .background(Circle().fill(Color.gray))

                                            }
                                        })

                                }

                            }
                        }
                        .frame(width: geometryReader.size.width - 5, height: geometryReader.size.height - 50, alignment: .center)
                        .navigationBarItems(trailing:
                                                Button(action: {
                                                    print("Edit button pressed ")
                                                }) {
                                                    Image(systemName: Constants.ImageNames.gear)
                                                })
                        
                    })

                }
                
            }
            
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

//.trace
//Appropriate for messages that contain information only when debugging a program.
//.debug
//Appropriate for messages that contain information normally of use only when debugging a program.
//.info
//Appropriate for informational messages.
//.notice
//Appropriate for conditions that are not error conditions, but that may require special handling.
//.warning
//Appropriate for messages that are not error conditions, but more severe than .notice
//.error
//Appropriate for error conditions.
//.critical
//Appropriate for critical error conditions that usually require i
