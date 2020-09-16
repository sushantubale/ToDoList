//
//  Enviroment.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 9/16/20.
//

import Foundation

public protocol Environment {}

public struct NetworkEnvironment: Environment {
    
    public let name: String
    public let host: String
    
    public var headers: [String: String] = [:]
    public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    
    public init(_ name: String, host: String) {
        self.name = name
        self.host = host
    }
    
}

public struct BundleEnvironment: Environment {
    
    let resource: String
    let fileExtension: String
    
    init(resource: String, fileExtension: String) {
        self.resource = resource
        self.fileExtension = fileExtension
    }
    
}
