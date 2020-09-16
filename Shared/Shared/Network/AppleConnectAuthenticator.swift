//
//  AppleConnectAuthenticator.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 9/16/20.
//

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
