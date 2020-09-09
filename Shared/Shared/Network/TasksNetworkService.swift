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
    private var dict: [String : Any]

    init(dict: [String : Any]) {
        self.dict = dict
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
    
    func fetchTasksData(_ url: String,_ completionHandler: @escaping (Error?, Data?) -> Void) {
        let arguments = ProcessInfo.processInfo.arguments
        if arguments.contains("UI_TESTING") {
            print("UI_TESTING available")
            completionHandler(nil, self.tasksData)

            
        } else {
            let data = try! JSONSerialization.data(withJSONObject: dict, options: [])
            
            HTTPPostJSON(url: "http://localhost:9002/graphql?query={todoByPerson{name state}}", data: data) { [weak self] (error, result) in
                guard let _ = self else {return}
                if(error != nil) {
                    print(error?.localizedDescription)
                    completionHandler(error, nil)
                    return
                }
                completionHandler(nil, result)
            }
        }
    }
}
