//
//  TypedNotification.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 9/16/20.
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


// MARK: - TypedNotificationCenter
public protocol TypedNotificationCenter {
    
    /// Posts a given notification to the notification center.
    ///
    /// - Parameter notification: The notification to post.
    func post<T: TypedNotification>(_ notification: T)
    
    /// Adds an entry to the notification center's dispatch table.
    ///
    /// - Parameters:
    ///   - type: The type of the notification to register the observer for.
    ///   - object: The object whose notifications the observer wants to receive.
    ///   - queue: The operation queue to which block should be added. If you pass nil, the block is run synchronously on the posting thread. Default is `.main`.
    ///   - block: The block to be executed when the notification is received.
    ///   - note: The notification posted.
    /// - Returns: An `NotificationObserver` object to act as the observer.
    func addObserver<T: TypedNotification>(for type: T.Type, object obj: T.Sender?, queue: OperationQueue?, using block: @escaping (_ note: T) -> Void) -> NotificationObserver
    
    /// Removes the given observer from the notification center's dispatch table.
    ///
    /// - Parameter observer: The observer to remove.
    func removeObserver(observer: NotificationObserver)
    
}


// MARK: - NotificationCenter
extension NotificationCenter: TypedNotificationCenter {
    
    public func post<T: TypedNotification>(_ notification: T) {
        post(notification.notification)
    }
    
    public func addObserver<T: TypedNotification>(for type: T.Type, object: T.Sender?, queue: OperationQueue? = .main, using block: @escaping (_ note: T) -> Void) -> NotificationObserver {
        let token = addObserver(forName: T.notificationName, object: object, queue: queue) { (notification) in
            guard let typedNotification = T.convert(from: notification) else {
               // Log.error("Typed notification could not be constructed from notification \(notification.name)")
                return
            }
            block(typedNotification)
        }
        
        return NotificationObserver(token: token, center: self)
    }
    
    public func removeObserver(observer: NotificationObserver) {
        guard observer.center == self else {
            assertionFailure("Attempted to remove observer from incorrect notification center. observer.center = \(observer.center)  AND  self = \(self)")
            return
        }
        removeObserver(observer.token)
    }
    
}

public class NotificationObserver {
    
    internal let token: NSObjectProtocol
    internal let center: NotificationCenter
    
    public init(token: NSObjectProtocol, center: NotificationCenter = NotificationCenter.default) {
        self.token = token
        self.center = center
    }
    
    deinit {
        center.removeObserver(token)
    }
    
}
