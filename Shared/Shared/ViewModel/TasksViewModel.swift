//
//  TasksViewModel.swift
//  ToDoList
//
//  Created by Sushant-Old on 8/15/20.
//

import Foundation
import Combine

class TasksViewModel: ObservableObject {
    
    private var tasksNetworkService: TasksNetworkService = TasksNetworkService(dict: ["name": "testName"])
    var taskData: [String: String] = [:]
    @Published var showActivityIndicator: Bool = true
    @Published var stateViewModel: StateViewModel?
    @Published var dummyTaskData: [String: Int] = [:]
    var count = 0
    
    func getTasksData() {
        print("tasksNetworkService.fetchTasksData")

        
        tasksNetworkService.fetchTasksData("http://localhost:9002/graphql?query={todoByPerson{name state}}") { [weak self] (err, result) in
            guard let strongSelf = self else {return}
            if(err != nil) {
                print(err?.localizedDescription as Any)
                return
            }
            if let data = result {
                let json = try! JSONDecoder().decode(StateViewModel.self, from: data)
                DispatchQueue.main.async {
                strongSelf.stateViewModel = json
                    let mappedData = strongSelf.stateViewModel.map { $0.data.todoByPerson }
                    if let mappedData = mappedData {
                        for i in mappedData.enumerated() {
                            strongSelf.taskData[i.element.name] = i.element.state
                            if var val = self?.dummyTaskData[i.element.state] {
                                self?.dummyTaskData[i.element.state]! += 1
                            } else {
                                strongSelf.dummyTaskData[i.element.state] = strongSelf.count + 1
                            }
                        }
                        strongSelf.showActivityIndicator = false

                    }
                }
            }
        }

    }
}
