//
//  NotificationObserver.swift
//  TEst
//
//  Created by Rick Silva on 1/24/18.
//  Copyright © 2018 Rick Silva. All rights reserved.
//

import Foundation

/// A wrapper class around a notification observer token.
/// - NOTE: When deinitialized, the token is automatically removed from the notification center.
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
