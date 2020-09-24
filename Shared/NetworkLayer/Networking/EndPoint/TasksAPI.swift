//
//  TasksEndPoint.swift
//  NetworkLayer
//
//  Created by Sushant Ubale on 2018/03/07.
//  Copyright © 2018 Sushant Ubale. All rights reserved.
//

import Foundation

public enum NetworkEnvironment {
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
        let server_url = Environment().configuration(PlistKey.ServerURL)

        switch server_url {
        case "UAT":
            return "http://localhost:9002-UAT/graphql?query={todoByPerson{name state}}"
        case "QA":
            return "http://localhost:9002-QA/graphql?query={todoByPerson{name state}}"
        case "DEV":
            return "http://localhost:9002-DEV/graphql?query={todoByPerson{name state}}"
        case "PROD":
            return "http://localhost:9002/graphql?query={todoByPerson{name state}}"
        default:
            return "http://localhost:9002/graphql?query={todoByPerson{name state}}"
        }
    }
    
    public var baseURL: URL {
        guard let url = URL(string: environmentBaseURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    public var path: String {
        switch self {
        case .tasks:
            return ""
        }
    }
    
    public var httpMethod: HTTPMethod {
        return .post
    }
    
    public var task: HTTPTask {
        switch self {
        case .tasks:
            return .requestParameters(bodyParameters: nil, bodyEncoding: ParameterEncoding.jsonEncoding, urlParameters: nil)
        }
    }
    
    public var headers: HTTPHeaders? {
        switch self {
        case .tasks:
            return ["name": "testName"]
        }
        return nil
    }
}

public enum PlistKey {
    case ServerURL
    
    func value() -> String {
        switch self {
        case .ServerURL:
            return "server_url"
        }
    }
}
public struct Environment {
    
    fileprivate var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }else {
                fatalError("Plist file not found")
            }
        }
    }
    public func configuration(_ key: PlistKey) -> String {
        switch key {
        case .ServerURL:
            return infoDict[PlistKey.ServerURL.value()] as! String
        }
    }
}
