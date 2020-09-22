//
//  EndPoint.swift
//  NetworkLayer
//
//  Created by Sushant Ubale on 2020/09/22.
//  Copyright © 2018 Sushant Ubale. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

