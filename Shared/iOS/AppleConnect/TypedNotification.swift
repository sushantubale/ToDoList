//
//  TypedNotification.swift
//  TEst
//
//  Created by Rick Silva on 1/24/18.
//  Copyright © 2018 Rick Silva. All rights reserved.
//

import Foundation

public protocol TypedNotification {
    
    /// The type of the type that sent the notification
    associatedtype Sender
    
    /// The name of the notification
    static var name: String { get }
    
    /// A conversion method to convert a `Notification` into this type
    ///
    /// - Parameter notification: The `Notification` to convert
    /// - Returns: The converted notification or `nil` if converstion fails
    static func convert(from notification: Notification) -> Self?
    
    /// The sender of the notification
    var sender: Sender { get }
    
}

public extension TypedNotification {
    
    private static var userInfoKey: String { return "TypedNotification" }
    
    // The default implementation uses the name of the type as the notification name
    static var name: String {
        return String(describing: self)
    }
    
    /// Convenience property to convert `name` into `Notification.Name`
    static var notificationName: Notification.Name {
        return Notification.Name("\(Self.name)")
    }
    
    /// Convenience property to convert a `TypedNotification` into `Notification`
    var notification: Notification {
        return Notification(name: Self.notificationName, object: sender, userInfo: [Self.userInfoKey: self])
    }
    
    // The default implementation pulls the `TypedNotification` out of the userInfo
    static func convert(from notification: Notification) -> Self? {
        return notification.userInfo?[userInfoKey] as? Self
    }
    
}
