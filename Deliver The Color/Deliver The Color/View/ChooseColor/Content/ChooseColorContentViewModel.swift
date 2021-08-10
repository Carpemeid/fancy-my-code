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
    
    private var timer: Timer?
    private var startDate: Date?
    
    private let dateComponentsFormatter = DateComponentsFormatter()
    
    init(delegate: ChooseColorContentViewModelDelegate) {
        self.delegate = delegate
        dateComponentsFormatter.unitsStyle = .positional
    }
    
    func bind(view: ChooseColorContentView) {
        self.view = view
    }
    
    func viewDidLoad() {
        
    }
    
    func viewDidAppear() {
        resetTimer()
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = nil
        startDate = Date()
        refreshTime()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.refreshTime()
        }
    }
    
    private func refreshTime() {
        guard let startDate = startDate else {
            return
        }
        
        let currentDate = Date()
        
        guard let timeStringValue = dateComponentsFormatter.string(from: startDate,
                                                                   to: currentDate) else {
            return
        }
        
        view?.set(time: timeStringValue)
    }
}
