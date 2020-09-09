//
//  TasksNetworkService.swift
//  ToDoList
//
//  Created by Sushant-Old on 8/15/20.
//

import Foundation

public class TasksNetworkService {
    
    private let tasksData: Data = {
        var data: Data? = Data()
        let path = Bundle.main.path(forResource: "Tasks", ofType: "json")
        if let url = path {
            let url1 = URL(fileURLWithPath: url)
            do {
                data = try! Data(contentsOf: url1)
            }
        }
        return data ?? Data()
    }()
    
    func fetchTasksData(_ url: String,_ completionHandler: @escaping (Data?, Error?) -> Void) {
        
            let arguments = ProcessInfo.processInfo.arguments
            if arguments.contains("UI_TESTING") {
                print("UI_TESTING available")
                self.testFetchTasksData { (data, error) in
                    completionHandler(data, nil)
                }
            } else {
                guard let url = URL(string: url) else {return}
                URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                    guard let strongSelf = self else {return}
                    if let _ = data {
                        completionHandler(strongSelf.tasksData,  nil)
                    } else {
                        completionHandler(nil, error)
                    }
                }.resume()
            }
    }
    
    func testFetchTasksData(_ completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(self.tasksData, nil)
    }
}

