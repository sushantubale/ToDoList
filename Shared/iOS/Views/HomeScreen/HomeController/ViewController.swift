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

    lazy var appleConnectDidCancelView: UIHostingController<AppleConnectDidCancelView> = {
        let appleConnectDidCancelView = UIHostingController(rootView: AppleConnectDidCancelView())
        appleConnectDidCancelView.view.translatesAutoresizingMaskIntoConstraints = false
        appleConnectDidCancelView.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        return appleConnectDidCancelView
    }()
    
    lazy var mainHomeView: UIHostingController<MainHomeView> = {
        let mainHomeView = UIHostingController(rootView: MainHomeView())
        mainHomeView.view.translatesAutoresizingMaskIntoConstraints = false
        mainHomeView.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        return mainHomeView
    }()

    lazy var appleConnectContext: ACMobileAuthenticationContext = {
        let context = ACMobileAuthenticationContext(hostViewController: self)
        context.environment = .production
        // THIS APP ID IS USED FOR TEST PURPOSE ONLY.
        // PLEASE USE YOUR OWN APP ID FOR REAL APP
        context.uiStyle = .light
        context.appID = 626
        return context
    }()
    
    var environment: ACEnvironment = ACEnvironment.production
    
    func initializeAppSession(_ session: Session, completion: () -> Void) {
        
        // CALL APP SERVER TO INITIALIZE APP SESSION
        completion()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSpinnerController()
        checkAuthentication()
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
    
    private func checkAuthentication() {
        self.authenticateWithCompletion() { [weak self] (result) in
            guard let strongSelf = self else {return}
            switch result {
            case .error(let error):
                print("Error: \(error)")
                
            case .session(let session):
                strongSelf.removeSpinnerController()
                strongSelf.addMainHomeView()
                print("Service Ticket: \(session.serviceTicket!)")
            }
        }
    }
    
    func authenticateWithCompletion(_ completion: @escaping (AuthenticationResult) -> Void) {
        
        let request = ACAuthenticationRequest()
        
        // !!! Remove the following line if you do not need cancalable request
        request.cancelable = false

        self.appleConnectContext.authenticate(with: request) { [weak self] (response) -> Void in
            guard let strongSelf = self else {return}

            if let error = response.error {
                if let acError = ACError(rawValue: error._code), error._domain == kAppleConnectErrorDomain {
                    switch acError {
                    case .cancelled:
                        completion(AuthenticationResult.error(acError))
                        strongSelf.showAppleConnectCancelView()
                    default:
                        strongSelf.presentAlert(error.localizedDescription) {
                            completion(AuthenticationResult.error(acError))
                        }
                    }
                } else {
                    strongSelf.presentAlert("Unknown Error: \(error)") {
                        completion(AuthenticationResult.error(ACError.other))
                    }
                }
            } else {
                let session = Session(response.userName!, environment: strongSelf.appleConnectContext.environment)
                session.serviceTicket = response.serviceTicket
                session.personID = response.personID
                strongSelf.initializeAppSession(session) {
                    completion(AuthenticationResult.session(session))
                }
            }
        }
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
        // CALL THIS METHOD IF YOU NEED TO DETERMINE USER NAME OF RECENTLY SIGNED IN USER
        // IF THERE IS NO SIGNED IN USER, API RETURNS NIL
        self.appleConnectContext.fetchCurrentUserName { (userName, error) in
            if let userName = userName {
                print("Signed in user name: \(userName)")
            }
        
            if let error = error {
                print("No signed in user \(error)")
            }
        }
    }
}

