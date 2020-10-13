//
//  TaskViewTestModel.swift
//  ToDoList
//
//  Created by Sushant-Old on 10/12/20.
//

import Foundation
import Combine

class TaskViewModel: ObservableObject {
    
    @Published var dummyTaskData: [String: Int] = [:]
    var cancellationToken: AnyCancellable? 
    @Published var stateViewModel: StateViewModel?
    @Published var taskData: [String: String] = [:]
    @Published var showActivityIndicator: Bool = true
    var count = 0

    init() {
        //getTasks()
        
        cancellationToken =
            TasksNetworkService
            .requests(.tasks)
            .catch { _ in Just((self.stateViewModel!, self.stateViewModel!))}
            .receive(on: RunLoop.main)
            .sink { (posts, comments) in
                self.stateViewModel = posts
                self.stateViewModel = comments
        }
    }
    
    func getTasks() {
        cancellationToken = TasksNetworkService.request(.tasks) // 4
            .mapError({ (error) -> Error in // 5
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in }, // 6
                  receiveValue: { data in
                    self.configureTasksData(data) // 7
                  })
    }
    
    func configureTasksData(_ stateViewModel: StateViewModel) {
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
                        self?.dummyTaskData[i.element.state] = strongSelf.count + 1
                    }
                }
                self?.showActivityIndicator = false
            }
        }
    }
    
}
