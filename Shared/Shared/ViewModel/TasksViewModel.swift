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
    @Published var stateViewModel: StateViewModel?
    private var dict: [String : Any]
    
    init(dict: [String : Any]) {
        self.dict = dict
    }
    
    func getTasksData() {
        print("tasksNetworkService.fetchTasksData")

        let data = try! JSONSerialization.data(withJSONObject: dict, options: [])

        HTTPPostJSON(url: "http://localhost:9002/graphql?query={todoByPerson{name state}}", data: data) { [weak self] (err, result) in
            guard let strongSelf = self else {return}
            if(err != nil) {
                print(err!.localizedDescription)
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
                                strongSelf.showActivityIndicator = false
                        }
                    }
                }
            }
        }
    }
    
    private func HTTPsendRequest(request: URLRequest,
                         callback: @escaping (Error?, Data?) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            if (err != nil) {
                callback(err,nil)
            } else {
                callback(nil, data)
            }
        }
        task.resume()
    }

    private func HTTPPostJSON(url: String,  data: Data,
                      callback: @escaping (Error?, Data?) -> Void) {
        let  urlWithQueryAllowed = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        var request = URLRequest(url: urlWithQueryAllowed!)
        request.httpMethod = "POST"
        request.addValue("application/json",forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        HTTPsendRequest(request: request) { (error, data) in
            callback(nil, data)
        }
    }
}
