//
//  StartChooseColorViewModel.swift
//  Deliver The Color
//
//  Created by Dan Andoni on 10/08/2021.
//

import Foundation

// allows decoupling from the context where the start choose color vm is used
// anyone implementing this delegate can use start choose color
// benefits unit testing
protocol StartChooseColorViewModelDelegate: AnyObject {
    func startChooseColorViewModelDidTapStart(_ viewModel: StartChooseColorViewModel)
}

// disallows using the concrete class and its functions directly
// benefits DI
protocol StartChooseColorViewModel {
    func viewDidTapStart()
}

// using final to block inheritance
final class StartChooseColorViewModelImpl: StartChooseColorViewModel {
    private weak var delegate: StartChooseColorViewModelDelegate?
    
    init(delegate: StartChooseColorViewModelDelegate) {
        self.delegate = delegate
    }
    
    func viewDidTapStart() {
        delegate?.startChooseColorViewModelDidTapStart(self)
    }
}
