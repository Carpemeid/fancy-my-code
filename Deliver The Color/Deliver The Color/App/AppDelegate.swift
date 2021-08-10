//
//  AppDelegate.swift
//  Deliver The Color
//
//  Created by Dan Andoni on 09/08/2021.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    // since I've removed the scene delegate, we need to now manually have a window property declared inside appdelegate
    // otherwise assigning to window property makes the compiler fail
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let chooseColorContentViewModel = ChooseColorContentViewModelImpl()
        let chooseColorViewController = ChooseColorContentViewController(viewModel: chooseColorContentViewModel)
        chooseColorContentViewModel.bind(view: chooseColorViewController)
        
        window?.rootViewController = chooseColorViewController
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

