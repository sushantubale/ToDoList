//
//  AuthenticationController.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 9/16/20.
//

import Foundation

public protocol AuthenticationControllerDelegate: class {
    func authenticationDidComplete(result: AppleConnectAuthenticationResult)
}

// MARK: - AuthenticationController
public final class AuthenticationController  {
    
    // MARK: Public Properties
    public typealias Completion = (AuthenticationResult) -> Void
    public static let shared = AuthenticationController()
    public var appleConnectAuthenticator: AppleConnectAuthenticator?
    public var isAuthenticating: Bool { return state == .authenticating }
    public var isAuthenticated: Bool { return state == .authenticated }
    
    // MARK: Private Properties
    private enum State {
        case unauthenticated
        case authenticating
        case authenticated
    }

    private var state: State = .unauthenticated
    private var pendingAuthenticationCompletions = [Completion]()
    
    // MARK: Public Methods
    public func authenticate(_ completion: @escaping Completion) {
        guard let appleConnectAuthenticator = appleConnectAuthenticator else { fatalError() }
        
        // Always store the completion so that it is invoked when authentication finishes
        pendingAuthenticationCompletions.append(completion)
        
        guard !appleConnectAuthenticator.isAuthenticating else { return }
        state = .authenticating

        appleConnectAuthenticator.authenticate()
    }
    
}

extension AuthenticationController: AuthenticationControllerDelegate {
    
    public func authenticationDidComplete(result: AppleConnectAuthenticationResult) {
        // If error exist, user is not authenticated.
        state = result.error == nil ? .authenticated : .unauthenticated
        
        // Make a copy of the completion handlers and clear out the old
        let pendingCompletions = pendingAuthenticationCompletions
        pendingAuthenticationCompletions.removeAll()
        
        // Invoke each of the pending completion handlers
        invokeCompletionHanders(pendingCompletions, with: result)
    }
    
}

// MARK: Private
private extension AuthenticationController {
    
    func invokeCompletionHanders(_ completions: [Completion], with result: AppleConnectAuthenticationResult) {
        let authResult = AuthenticationResult(acToken: result.acToken, prsID: result.prsID, error: result.error)
        
        completions.forEach { completion in
            DispatchQueue.main.async { completion(authResult) }
        }
    }
    
}

// MARK: - AuthenticationResult
public struct AuthenticationResult {
    let acToken: String?
    let prsID: String?
    let error: Error?
}
