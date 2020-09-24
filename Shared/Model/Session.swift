//
//  Session.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 9/18/20.
//

import Foundation
import AppleConnectClient

class Session {
    var userName: String
    var environment: ACEnvironment
    var personID: NSNumber?
    var serviceTicket: String?
    init(_ userName: String, environment: ACEnvironment = ACEnvironment.production) {
        self.userName = userName
        self.environment = environment
    }
}

enum AuthenticationResult {
    case error(ACError)
    case session(Session)
}
