//
//  MockChooseColorContentView.swift
//  Deliver The Color Tests
//
//  Created by Dan Andoni on 10/08/2021.
//

import UIKit
@testable import Deliver_The_Color

final class MockChooseColorContentView: ChooseColorContentView {
    var setTimeParam: String?
    func set(time: String) {
        setTimeParam = time
    }
    
    var setContentViewControllerParams: (UIViewController, Bool)?
    func set(contentViewController: UIViewController, isNavigatingForward: Bool) {
        setContentViewControllerParams = (contentViewController, isNavigatingForward)
    }
    
    var presentParam: UIViewController?
    func present(viewController: UIViewController) {
        presentParam = viewController
    }
}
