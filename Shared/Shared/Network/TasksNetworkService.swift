//
//  TasksNetworkService.swift
//  ToDoList
//
//  Created by Sushant-Old on 8/15/20.
//

import Foundation

class TasksNetworkService {
    
    private let tasksData: Data = {
        let data: Data?
        let path = Bundle.main.path(forResource: "Tasks", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            data = try! Data(contentsOf: url)
        }
        return data ?? Data()
    }()

    func fetchTasksData(_ url: String,_ completionHandler: @escaping (Data?, Error?) -> Void) {
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
