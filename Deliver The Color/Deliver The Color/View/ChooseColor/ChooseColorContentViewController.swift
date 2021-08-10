//
//  ChooseColorContentViewController.swift
//  Deliver The Color
//
//  Created by Dan Andoni on 10/08/2021.
//

import UIKit

// interface to be used by viewmodel
// allows for easy testing of view model
// independent of VC
// useful in test targets where we don't want to instantiate VC
protocol ChooseColorContentView: AnyObject {
    func set(time: String)
    func set(contentViewController: UIViewController, isNavigatingForward: Bool)
    func present(viewController: UIViewController)
}

// using final to disallow inheritance
final class ChooseColorContentViewController: UIViewController {
    private let viewModel: ChooseColorContentViewModel
    private let pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                          navigationOrientation: .horizontal)
    
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var pageViewControllerContainerView: UIView!
    
    // forcing the creation of the VC in the only allowed way
    // in which this class can correctly function
    init(viewModel: ChooseColorContentViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: String(describing: type(of: self)),
                   bundle: Bundle(for: type(of: self)))
        
        addChild(pageViewController)
    }
    
    private override init(nibName nibNameOrNil: String?,
                          bundle nibBundleOrNil: Bundle?) {
        fatalError("not implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurePageViewController()
        
        viewModel.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
    
    private func configurePageViewController() {
        pageViewController.view.embed(in: pageViewControllerContainerView)
        
        pageViewController.didMove(toParent: self)
    }
}

extension ChooseColorContentViewController: ChooseColorContentView {
    func set(time: String) {
        timeLabel.text = time
    }
    
    func set(contentViewController: UIViewController, isNavigatingForward: Bool) {
        pageViewController.setViewControllers([contentViewController],
                                              direction: isNavigatingForward ? .forward : .reverse,
                                              animated: true)
    }
    
    func present(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
}
