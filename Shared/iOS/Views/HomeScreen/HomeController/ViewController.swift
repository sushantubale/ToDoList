//
//  ViewController.swift
//  ACMInternalSample
//
//  Created by Volodymyr Prokurashko on 11/3/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

import UIKit
import SwiftUI
import AppleConnectClient
import Combine

class ViewController: UIViewController, ObservableObject {
    
    private lazy var child: SpinnerViewController = {
        let spinnerController = SpinnerViewController()
        spinnerController.view.frame = view.frame
        return spinnerController
    }()
    
    private lazy var appleConnectHelper = AppleConnectHelper(appleConnectContext: appleConnectContext)
    lazy var appleConnectDidCancelView: UIHostingController<AppleConnectDidCancelView> = {
        let appleConnectDidCancelView = UIHostingController(rootView: AppleConnectDidCancelView())
        appleConnectDidCancelView.view.translatesAutoresizingMaskIntoConstraints = false
        appleConnectDidCancelView.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        return appleConnectDidCancelView
    }()
    
    private lazy var mainHomeView: UIHostingController<MainHomeView> = {
        let mainHomeView = UIHostingController(rootView: MainHomeView())
        mainHomeView.view.translatesAutoresizingMaskIntoConstraints = false
        mainHomeView.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        return mainHomeView
    }()

    private lazy var appleConnectContext: ACMobileAuthenticationContext = {
        let context = ACMobileAuthenticationContext(hostViewController: self)
        context.environment = .production
        // THIS APP ID IS USED FOR TEST PURPOSE ONLY.
        // PLEASE USE YOUR OWN APP ID FOR REAL APP
        context.uiStyle = .light
        context.appID = 626
        return context
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSpinnerController()
        self.appleConnectHelper.checkAuthentication { (acError, session) in
            guard acError == nil else {
                if let error = acError {
                    self.presentAlert("\(error.rawValue)") {
                        print("error occured")
                    }
                }
                return
            }
            self.removeSpinnerController()
            self.addMainHomeView()
        }
    }
    
    private func showAppleConnectCancelView() {
        removeSpinnerController()
        addChild(appleConnectDidCancelView)
        view.addSubview(appleConnectDidCancelView.view)
        didMove(toParent: self)
    }
    
    private func addSpinnerController() {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    private func removeSpinnerController() {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
    private func addMainHomeView() {
        addChild(mainHomeView)
        view.addSubview(mainHomeView.view)
        didMove(toParent: self)
    }
    
    func presentAlert(_ string: String, completion: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: "USE YOUR OWN ERROR HANDLING!", message: string, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) in
            completion()
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        self.appleConnectContext.fetchCurrentUserName { (username, error) in
            if let userName = username {
                print("Signed in user name: \(userName)")
            }
            if let error = error {
                print("No signed in user \(error)")
            }
        }
    }
}


