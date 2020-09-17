//
//  TypedNotificationCenter.swift
//  TEst
//
//  Created by Rick Silva on 1/24/18.
//  Copyright © 2018 Rick Silva. All rights reserved.
//

import Foundation

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
                print("Typed notification could not be constructed from notification \(notification.name)")
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
