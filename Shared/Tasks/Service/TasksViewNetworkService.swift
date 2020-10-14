//
//  TasksViewNetworkService.swift
//  ToDoList
//
//  Created by Sushant-Old on 10/14/20.
//

import Foundation
import Combine

final class TasksViewNetworkService: APIProtocol {
    
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }
    
    func getTasks(_ tasksRequest: TasksAPI) -> AnyPublisher<TasksModel, Error> {
        let request = try! self.buildRequest(from: tasksRequest)
        return execute(request, TasksModel.self, .main, 1)
    }
    
    private func buildRequest(from route: EndPointType) throws -> URLRequest {
        
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
    
    private func configureParameters(bodyParameters: Parameters?,
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
    
     func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}

private extension APIError {
    
}
