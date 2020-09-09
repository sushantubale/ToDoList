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
    @Published var taskData: [String: String] = [:]
    @Published var showActivityIndicator: Bool = true
    @Published var stateViewModel: StateViewModel?
    
    func getTasksData() {
        print("tasksNetworkService.fetchTasksData")

        
        tasksNetworkService.fetchTasksData("http://localhost:9002/graphql?query={todoByPerson{name state}}") { [weak self] (err, result) in
            guard let strongSelf = self else {return}
            if(err != nil) {
                print(err?.localizedDescription)
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
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                strongSelf.showActivityIndicator = false
                            }

                        }
                    }
                }
            }
        }

    }
}
