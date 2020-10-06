//
//  HTTPTask.swift
//  NetworkLayer
//
//  Created by Sushant Ubale on 2020/09/22.
//  Copyright © 2018 Sushant Ubale. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
                           bodyEncoding: ParameterEncoding,
                           urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
                                     bodyEncoding: ParameterEncoding,
                                     urlParameters: Parameters?,
                                     additionHeaders: HTTPHeaders?)
}


