//
//  ToDoListApp.swift
//  Shared
//
//  Created by Sushant-Old on 8/12/20.
//

import SwiftUI

@main
struct ToDoListApp: App {
    @State private var hasOnboarded = false
//    private let pushNotificationController = PushNotificationsController()
    private let appleConnectController = AppleConnectController()
    private var observers: [NotificationObserver] = []
    private var appStarting = false
    private var pushNotificationDeviceToken: String?

    var body: some Scene {
           WindowGroup {
               if hasOnboarded {
                   ContentView()
                       .onAppear(perform: checkOnboarding)
               } else {
                   MessagesView()
                       .onAppear(perform: checkOnboarding)
               }
           }
       }
    
    func checkOnboarding() {
        // Login flow
        // Login authenticated, hasOnboarded = true
        appleConnectController.authenticationControllerDelegate = AuthenticationController.shared
        AuthenticationController.shared.appleConnectAuthenticator = appleConnectController
    }

}
