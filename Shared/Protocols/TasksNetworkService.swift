//
//  TasksNetworkService.swift
//  ToDoList
//
//  Created by Sushant-Old on 10/12/20.
//

import Foundation
import Combine

// 1
enum TasksNetworkService {
    static let apiClient = APIClient()
}

extension TasksNetworkService {
    
    static func request(_ path: TasksAPI) -> AnyPublisher<StateViewModel, Error> {
        
        do {
            let request = try! TasksNetworkService.buildRequest(from: path)
            return apiClient.run(request) // 5
                .map(\.value) // 6
                .eraseToAnyPublisher() // 7
        } catch  {
            print(error)
        }
    }
    
    fileprivate static func buildRequest(from route: EndPointType) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 30.0)
        let dict: [String : Any] = [:]
        let data = try! JSONSerialization.data(withJSONObject: dict, options: [])
        request.httpBody = data
        request.allHTTPHeaderFields = route.headers
        request.httpMethod = route.httpMethod.rawValue
        request.httpBody = data
        
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate static func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate static func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

    fileprivate static func testFetchTasksData(_ completionHandler: @escaping (StateViewModel?, Error?) -> Void) {
//        do {
//            print(self.tasksData)
//            let jsonData = try JSONSerialization.jsonObject(with: self.tasksData, options: .mutableContainers)
//            print(jsonData)
//            let apiResponse = try JSONDecoder().decode(StateViewModel.self, from: self.tasksData)
//            completionHandler(apiResponse, nil)
//        } catch {
//            print(error)
//            completionHandler(nil, error)
//        }
    }
    
    
    fileprivate static func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
