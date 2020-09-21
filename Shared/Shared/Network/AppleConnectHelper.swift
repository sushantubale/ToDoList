//
//  AppleConnectHelper.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 9/18/20.
//

import Foundation
import AppleConnectClient

class AppleConnectHelper {
    
    var appleConnectContext: ACMobileAuthenticationContext?
    
    init(appleConnectContext: ACMobileAuthenticationContext) {
        self.appleConnectContext = appleConnectContext
    }
    
    var environment: ACEnvironment = ACEnvironment.production
    
    func initializeAppSession(_ session: Session, completion: () -> Void) {
        
        // CALL APP SERVER TO INITIALIZE APP SESSION
        completion()
    }

    func fetchUsername(_ completionHandler: @escaping (String?, Error?) -> Void) {
        self.appleConnectContext?.fetchCurrentUserName { (userName, error) in
            if let userName = userName {
                print("Signed in user name: \(userName)")
                completionHandler(userName, nil)
            }
        
            if let error = error {
                completionHandler(nil, error)
            }
        }
    }
    
    func checkAuthentication(_ completionHandler: @escaping (ACError?, Session?) -> Void) {
        self.authenticateWithCompletion() { (result) in
            switch result {
            case .error(let error):
                print("Error: \(error)")
                completionHandler(error, nil)
            case .session(let session):
                print("Service Ticket: \(session.serviceTicket!)")
                completionHandler(nil, session)
            }
        }
    }
    
    func authenticateWithCompletion(_ completion: @escaping (AuthenticationResult) -> Void) {
        
        let request = ACAuthenticationRequest()
        
        // !!! Remove the following line if you do not need cancalable request
        request.cancelable = false
        
        self.appleConnectContext?.authenticate(with: request) { [weak self] (response) -> Void in
            guard let strongSelf = self else {return}
            
            if let error = response.error {
                if let acError = ACError(rawValue: error._code), error._domain == kAppleConnectErrorDomain {
                    switch acError {
                    case .cancelled:
                        completion(AuthenticationResult.error(acError))
                    default:
                        completion(AuthenticationResult.error(acError))
                    }
                } else {
                    completion(AuthenticationResult.error(ACError.other))
                }
            } else {
                let session = Session(response.userName!, environment: strongSelf.appleConnectContext!.environment)
                session.serviceTicket = response.serviceTicket
                session.personID = response.personID
                strongSelf.initializeAppSession(session) {
                    completion(AuthenticationResult.session(session))
                }
            }
        }
    }
}
