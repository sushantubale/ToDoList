//
//  AppleConnectFacadeLayer.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 9/18/20.
//

import UIKit
import SwiftUI
import AppleConnectClient
import Combine

struct AppleConnectFacadeLayer: UIViewControllerRepresentable {
    let storyboard: String
    let VC: String

  func makeUIViewController(context: UIViewControllerRepresentableContext<AppleConnectFacadeLayer>) -> ViewController {
    
    //Load the storyboard
    let controller = UIStoryboard(name: "Storyboard", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController

    //Load the ViewController
     return controller
    
  }
  
  func updateUIViewController(_ uiViewController: ViewController, context: UIViewControllerRepresentableContext<AppleConnectFacadeLayer>) {
  }
}
