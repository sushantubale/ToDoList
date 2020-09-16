//
//  AppleConnectController.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 9/16/20.
//

import UIKit
import AppleConnectClient

final class AppleConnectController: AppleConnectAuthenticator {
    
    typealias Completion = (AppleConnectAuthenticationResult) -> Void
    weak var authenticationControllerDelegate: AuthenticationControllerDelegate?

    private var window: UIWindow?
    
    // MARK: AppleConnectAuthenticator
    private(set) var isAuthenticating: Bool = false
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc func applicationDidBecomeActive(_ notification: Notification) {
        guard isAuthenticating == false else { return }
        beginAuthentication()
    }
    
    func authenticate() {
        guard isAuthenticating == false else { return }
        
        #if IOS_SIMULATOR
            // If the app isn't active we don't want to try to authenticate.
            // This fixes an issue with the AC login prompt not accepting keyboard events
            guard UIApplication.shared.applicationState == .active else { return }
        #endif
        
        beginAuthentication()
    }
    
}

// MARK: Private
private extension AppleConnectController {
    
    func beginAuthentication() {
        isAuthenticating = true
        
        createAndShowWindow()
        
        guard let hostViewController = window?.rootViewController else { fatalError() }
        
        let authContext = ACMobileAuthenticationContext(hostViewController: hostViewController)
        
        // We have a light status bar, and by default, Apple Connect
        // uses the dark theme for this. This is a bad UI, so we need
        // to manually set the uiStyle to light
        authContext.uiStyle = .light
        
        let request = ACAuthenticationRequest()
        request.environment = (AppEnvironment.isPROD) ? .production : .UAT
        request.appID = AppEnvironment.appID
        request.suppressSingleSignOn = false
        
        authContext.authenticate(with: request) { (response) in
            self.finishAuthentication(response: response)
        }
    }
    
    func finishAuthentication(response: ACAuthenticationResponse) {
        let personID = response.personID?.stringValue
        
        // Check to see if a new user has signed in. If so, update the current user
        if let personID = personID, let userName = response.userName {
            if personID != User.current?.personID {
                User.current = User(userName: userName, personID: personID)
            }
        } else {
            // no authenticated user so remove the current user
            User.current = nil
        }
        
        let result = AppleConnectAuthenticationResult(acToken: response.serviceTicket, userName: response.userName, prsID: personID, error: response.error)
        
        authenticationControllerDelegate?.authenticationDidComplete(result: result)
        
        self.window?.isHidden = true
        self.window = nil
        
        self.isAuthenticating = false
        
        NotificationCenter.default.post(AppleConnectDidFinishNotification(sender: self))
    }
    
    
    func createAndShowWindow() {
        if window == nil {
            let viewController = UIViewController()
            viewController.view.backgroundColor = .clear
            viewController.view.isOpaque = false
            
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.windowLevel = .alert
            window?.rootViewController = viewController
            window?.addSubview(viewController.view)
        }
        
        window?.isHidden = false
        window?.makeKeyAndVisible()
    }
    
}

// MARK: - AppleConnectDidFinishNotification
struct AppleConnectDidFinishNotification: TypedNotification {
    let sender: AppleConnectController
}
