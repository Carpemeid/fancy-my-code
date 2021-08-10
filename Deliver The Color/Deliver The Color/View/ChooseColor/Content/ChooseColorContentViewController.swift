//
//  ChooseColorContentViewController.swift
//  Deliver The Color
//
//  Created by Dan Andoni on 10/08/2021.
//

import UIKit

// pattern for vc and vm creation

// entity for creating choose color content view controller
protocol ChooseColorContentViewControllerFactory {
    func chooseColorContentViewController(viewModelDelegate: ChooseColorContentViewModelDelegate) -> UIViewController
}

// default implementation for creating choose color content view controller
extension ChooseColorContentViewControllerFactory {
    func chooseColorContentViewController(viewModelDelegate: ChooseColorContentViewModelDelegate) -> UIViewController {
        let viewModel = ChooseColorContentViewModelImpl(delegate: viewModelDelegate)
        let viewController = ChooseColorContentViewController(viewModel: viewModel)
        viewModel.bind(view: viewController)
        
        return viewController
    }
}

// interface to be used by viewmodel
// allows for easy testing of view model
// independent of VC
// useful in test targets where we don't want to instantiate VC
protocol ChooseColorContentView: AnyObject {
    func set(time: String)
    func set(contentViewController: UIViewController)
}

// using final to disallow inheritance
final class ChooseColorContentViewController: UIViewController {
    private let viewModel: ChooseColorContentViewModel
    
    @IBOutlet private weak var timeLabel: UILabel!
    
    // forcing the creation of the VC in the only allowed way
    // in which this class can correctly function
    init(viewModel: ChooseColorContentViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: String(describing: type(of: self)),
                   bundle: Bundle(for: type(of: self)))
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

        viewModel.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
}

extension ChooseColorContentViewController: ChooseColorContentView {
    func set(time: String) {
        timeLabel.text = time
    }
    
    func set(contentViewController: UIViewController) {
        
    }
}
