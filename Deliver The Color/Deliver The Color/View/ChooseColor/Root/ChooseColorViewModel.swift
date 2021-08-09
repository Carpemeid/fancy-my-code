//
//  ChooseColorViewModel.swift
//  Deliver The Color
//
//  Created by Dan Andoni on 10/08/2021.
//

import Foundation

protocol ChooseColorViewModel {
    func viewDidLoad()
}

final class ChooseColorViewModelImpl: ChooseColorViewModel {
    typealias Container = StartChooseColorViewControllerFactory
    
    // fancy construct to encapsulate all the pontetial default implementations of any factory protocol
    // of which the container typealias may be composed
    // for usage look below in the constructor
    private final class ContainerImpl: Container {}
    
    private let startChooseColorVCFactory: StartChooseColorViewControllerFactory
    private weak var view: ChooseColorView?
    
    init(container: Container = ContainerImpl()) {
        self.startChooseColorVCFactory = container
    }
    
    func bind(view: ChooseColorView) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.set(viewController: startChooseColorVCFactory.startChooseColorViewController(viewModelDelegate: self),
                  asNext: true)
    }
}

extension ChooseColorViewModelImpl: StartChooseColorViewModelDelegate {
    func startChooseColorViewModelDidTapStart(_ viewModel: StartChooseColorViewModel) {
        debugPrint("--- did tap start")
    }
}
