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
                    VStack(alignment: .center) {
                        Spacer()
                            activityIndicator
                            .frame(width: geometryReader.size.width / 2, height: geometryReader.size.width / 2, alignment: .center)
                            .padding([.leading, .trailing, .top, .bottom], 100)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    
                } else if self.taskViewModel.showActivityIndicator == false {
                    
                    ScrollView(.vertical, showsIndicators: false, content: {
                        SearchBar(text: "Search")
                        
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
                        .navigationTitle(Constants.Tasks.headerTitle)
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
        .accessibility(label: Text("TasksTab"))
        .onAppear(perform: onLoad)
        .onDisappear(perform: onUnload)
    }
    
    func onUnload() {
        print("onUnload called")
    }
    
    func onLoad() {
        
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
