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
    
    static let environment : NetworkEnvironment = .production
    let router = Router<TasksAPI>()
    
    func getTasks(completion: @escaping (_ tasks: StateViewModel?,_ error: String?)->()) {
        
        let arguments = ProcessInfo.processInfo.arguments
        if arguments.contains("UI_TESTING") {
            print("UI_TESTING available")
            self.testFetchTasksData { (data, error) in
                completion(data, nil)
            }
        } else {
            router.request(.tasks) { (data, response, error) in
                if error != nil {
                    completion(nil, "Please check your network connection.")
                }
                
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            completion(nil, NetworkResponse.noData.rawValue)
                            return
                        }
                        do {
                            print(responseData)
                            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                            print(jsonData)
                            let apiResponse = try JSONDecoder().decode(StateViewModel.self, from: responseData)
                            completion(apiResponse, nil)
                        }catch {
                            print(error)
                            completion(nil, NetworkResponse.unableToDecode.rawValue)
                        }
                    case .failure(let networkFailureError):
                        completion(nil, networkFailureError)
                    }
                }
            }
        }
    }
    
    fileprivate func testFetchTasksData(_ completionHandler: @escaping (StateViewModel?, Error?) -> Void) {
        do {
            print(self.tasksData)
            let jsonData = try JSONSerialization.jsonObject(with: self.tasksData, options: .mutableContainers)
            print(jsonData)
            let apiResponse = try JSONDecoder().decode(StateViewModel.self, from: self.tasksData)
            completionHandler(apiResponse, nil)
        } catch {
            print(error)
            completionHandler(nil, error)
        }
    }
    
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
