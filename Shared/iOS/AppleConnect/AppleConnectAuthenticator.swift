//
//  AppleConnectAuthenticator.swift
//  MySecurity
//
//  Created by Rick Silva on 10/23/17.
//  Copyright © 2017 Apple, Inc. All rights reserved.
//

import Foundation

// MARK: - AppleConnectAuthenticator
public protocol AppleConnectAuthenticator {
    typealias Completion = (AppleConnectAuthenticationResult) -> Void
    var isAuthenticating: Bool { get }
    func authenticate()
}

// MARK: - AppleConnectAuthenticationResult
public struct AppleConnectAuthenticationResult {
    let acToken: String?
    let userName: String?
    let prsID: String?
    let error: Error?
    
    public init(acToken: String?, userName: String?, prsID: String?, error: Error?) {
        self.acToken = acToken
        self.userName = userName
        self.prsID = prsID
        self.error = error
    }
    
}
