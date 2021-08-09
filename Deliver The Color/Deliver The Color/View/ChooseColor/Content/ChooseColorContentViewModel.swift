//
//  ChooseColorContentViewModel.swift
//  Deliver The Color
//
//  Created by Dan Andoni on 10/08/2021.
//

import Foundation

// decoupling the choose color content view model from the context where it can be used
// allows for usage in any scenario
protocol ChooseColorContentViewModelDelegate: AnyObject {
    func chooseColorContentViewModelDidFinish(_ viewModel: ChooseColorContentViewModel)
}

// limiting access to view model
// decoupling the intended behaviour from the concrete implementation
protocol ChooseColorContentViewModel {
    func viewDidLoad()
    func viewDidAppear()
}

final class ChooseColorContentViewModelImpl: ChooseColorContentViewModel {
    private weak var delegate: ChooseColorContentViewModelDelegate?
    private weak var view: ChooseColorContentView?
    
    init(delegate: ChooseColorContentViewModelDelegate) {
        self.delegate = delegate
    }
    
    func bind(view: ChooseColorContentView) {
        self.view = view
    }
    
    func viewDidLoad() {
        
    }
    
    func viewDidAppear() {
        
    }
}
