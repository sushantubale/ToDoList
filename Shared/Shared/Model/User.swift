//
//  User.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 9/16/20.
//

import Foundation

public struct User {
    
    public static var current: User? {
        didSet {
            guard let _ = oldValue, let newValue = current else { return }
            
        }
    }

    public let userName: String
    public let personID: String
    public let sessionID: String
    
    public init(userName: String, personID: String) {
        self.userName = userName
        self.personID = personID
        self.sessionID = UUID().uuidString
    }
    
}
