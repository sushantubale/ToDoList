//
//  TasksViewModel.swift
//  ToDoList
//
//  Created by Sushant-Old on 8/15/20.
//

import Foundation
import Combine

class TasksViewModel: ObservableObject {
    
    private var tasksNetworkService: TasksNetworkService = TasksNetworkService()
    @Published var taskData: [String: String] = [:]
    @Published var showActivityIndicator: Bool = true
    @Published var stateViewModel: TasksModel?
    @Published var dummyTaskData: [String: Int] = [:]
    var count = 0
    
    func getTasksData() {
        print("tasksNetworkService.fetchTasksData")
        
        tasksNetworkService.getTasks { [weak self] (stateViewModel, error) in
            guard let strongSelf = self else {return}
            if(error != nil) {
                print(error?.localizedUppercase as Any)
                return
            }
            if let data = stateViewModel {
                strongSelf.configureTasksData(data)
            }
        }
    }
    
    func configureTasksData(_ stateViewModel: TasksModel) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.stateViewModel = stateViewModel
            let mappedData = strongSelf.stateViewModel.map { $0.data.todoByPerson }
            if let mappedData = mappedData {
                for i in mappedData.enumerated() {
                    strongSelf.taskData[i.element.name] = i.element.state
                    if var _ = strongSelf.dummyTaskData[i.element.state] {
                        strongSelf.dummyTaskData[i.element.state]! += 1
                    } else {
                        strongSelf.dummyTaskData[i.element.state] = strongSelf.count + 1
                    }
                }
                strongSelf.showActivityIndicator = false
            }
        }
    }
}
