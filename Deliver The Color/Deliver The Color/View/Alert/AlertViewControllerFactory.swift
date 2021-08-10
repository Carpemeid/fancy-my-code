//
//  AlertViewControllerFactory.swift
//  Deliver The Color
//
//  Created by Dan Andoni on 10/08/2021.
//

import UIKit

protocol AlertViewControllerFactory {
    func somethingWentWrongAlertViewController(completion: @escaping () -> Void) -> UIViewController
    func chooseColorAlertViewController(isSuccess: Bool,
                                        inTime timeInterval: TimeInterval,
                                        completion: @escaping () -> Void) -> UIViewController
}

extension AlertViewControllerFactory {
    func somethingWentWrongAlertViewController(completion: @escaping () -> Void) -> UIViewController {
        let alertViewController = UIAlertController(title: "Something went wrong", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Try again", style: .default) { _ in
            completion()
        }
        
        alertViewController.addAction(action)
        
        return alertViewController
    }
    
    func chooseColorAlertViewController(isSuccess: Bool,
                                        inTime timeInterval: TimeInterval,
                                        completion: @escaping () -> Void) -> UIViewController {
        let title = isSuccess ? "You've failed the task" : "You've succeeded"
        let message = String(format: "It took you %.2f seconds", timeInterval)
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Try again", style: .default) { _ in
            completion()
        }
        
        alertViewController.addAction(action)
        
        return alertViewController
    }
}


