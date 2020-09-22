//
//  TasksViewModel.swift
//  ToDoList
//
//  Created by Sushant-Old on 8/15/20.
//

import Foundation
import Combine

class TasksViewModel: ObservableObject {
    
    private var tasksNetworkService: NetworkManager = NetworkManager()
    var taskData: [String: String] = [:]
    @Published var showActivityIndicator: Bool = true
    @Published var stateViewModel: StateViewModel?
    @Published var dummyTaskData: [String: Int] = [:]
    var count = 0
    
    func getTasksData() {
        print("tasksNetworkService.fetchTasksData")
        
        tasksNetworkService.getTasks { (stateViewModel, error) in
            
        }
    }
}
