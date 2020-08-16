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
    @Published var taskTypes: [String] = []
    @Published var taskCount: [Int] = []
    @Published var showActivityIndicator = true
    
    init() {
        self.getTasksData()
    }
    
    func getTasksData() {
        tasksNetworkService.fetchTasksData("https://www.abc.com") { (data, error) in
            guard let data = data else {return}
            do {
                let formattedData = try? JSONDecoder().decode(TasksModel.self, from: data)
                DispatchQueue.main.async {
                    
                    if let t1 = formattedData?.taksTypes {
                        for i in 0..<t1.count {
                            self.taskTypes.append(t1[i])
                        }
                    }
                    if let t2 = formattedData?.taksCount {
                        for i in 0..<t2.count {
                            self.taskCount.append(t2[i])
                        }
                    }
                    self.showActivityIndicator = false
                }
            } 
        }
    }
}
