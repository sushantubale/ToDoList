//
//  TasksAPI.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/07.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case uat
    case dev
}

public enum TasksAPI {
    case tasks
}

extension TasksAPI: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "http://localhost:9002/graphql?query={todoByPerson{name state}}"
        case .qa: return ""
        case .uat: return ""
        case .dev: return ""
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .tasks:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var task: HTTPTask {
        switch self {
        case .tasks:
            return .requestParameters(bodyParameters: nil, bodyEncoding: ParameterEncoding.jsonEncoding, urlParameters: nil)
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


