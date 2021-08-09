//
//  StartChooseColorViewController.swift
//  Deliver The Color
//
//  Created by Dan Andoni on 10/08/2021.
//

import UIKit

// pattern for vc and vm creation

// entity for creating the start choose color view controller
protocol StartChooseColorViewControllerFactory {
    func startChooseColorViewController(viewModelDelegate: StartChooseColorViewModelDelegate) -> UIViewController
}

// default implementation for creating start choose color view controller
extension StartChooseColorViewControllerFactory {
    func startChooseColorViewController(viewModelDelegate: StartChooseColorViewModelDelegate) -> UIViewController {
        let viewModel = StartChooseColorViewModelImpl(delegate: viewModelDelegate)
        
        return StartChooseColorViewController(viewModel: viewModel)
    }
}

// using final to block inheritance
final class StartChooseColorViewController: UIViewController {
    private let viewModel: StartChooseColorViewModel
    
    // forcing the creation of the VC in the only allowed way
    // in which this class can correctly function
    init(viewModel: StartChooseColorViewModel) {
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
    
    @IBAction func startAction(_ sender: UIButton) {
        // keeping all the logic outside VC in order to enable easy unit testing
        viewModel.viewDidTapStart()
    }
}
