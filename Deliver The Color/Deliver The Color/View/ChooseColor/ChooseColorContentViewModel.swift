//
//  ChooseColorContentViewModel.swift
//  Deliver The Color
//
//  Created by Dan Andoni on 10/08/2021.
//

import Foundation

// limiting access to view model
// decoupling the intended behaviour from the concrete implementation
protocol ChooseColorContentViewModel {
    func viewDidLoad()
    func viewDidAppear()
}

final class ChooseColorContentViewModelImpl: ChooseColorContentViewModel {
    typealias Container = SelectCorrectColorViewControllerFactory &
        ColorItemDataSourceGeneratorFactory &
        SelectWrongColorViewControllerFactory &
        AlertViewControllerFactory
    
    private final class ContainerImpl: Container {}
    
    private weak var view: ChooseColorContentView?
    
    private var timer: Timer?
    private var startDate: Date?
    
    private let dateComponentsFormatter = DateComponentsFormatter()
    private let selectCorrectColorVCFactory: SelectCorrectColorViewControllerFactory
    private let selectWrongColorVCFactory: SelectWrongColorViewControllerFactory
    private let alertVCFactory: AlertViewControllerFactory
    private let colorItemDataSourceGenerator: ColorItemDataSourceGenerator
    
    init(container: Container = ContainerImpl()) {
        self.selectCorrectColorVCFactory = container
        self.selectWrongColorVCFactory = container
        self.alertVCFactory = container
        self.colorItemDataSourceGenerator = container.colorItemDataSourceGenerator()
        dateComponentsFormatter.unitsStyle = .positional
    }
    
    func bind(view: ChooseColorContentView) {
        self.view = view
    }
    
    func viewDidLoad() {
        switchToSelectCorrectColorView(isNavigatingForward: true)
    }
    
    private func switchToSelectCorrectColorView(isNavigatingForward: Bool) {
        let colorItems = colorItemDataSourceGenerator.randomColorItems()
        
        guard colorItems.count > 1,
              let correctColor = colorItems.first,
              let wrongColor = colorItems.last else {
            return
        }
        
        let selectCorrectColorVC = selectCorrectColorVCFactory.selectCorrectColorViewController(viewModelDelegate: self,
                                                                                                      correctColor: correctColor,
                                                                                                      wrongColor: wrongColor)
        
        view?.set(contentViewController: selectCorrectColorVC, isNavigatingForward: isNavigatingForward)
    }
    
    func viewDidAppear() {
        resetTimer()
    }
    
    private func resetTimer() {
        stopTimer()
        startDate = Date()
        refreshTime()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.refreshTime()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
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
    
    private func tryAgain() {
        switchToSelectCorrectColorView(isNavigatingForward: false)
        resetTimer()
    }
}

extension ChooseColorContentViewModelImpl: SelectCorrectColorViewModelDelegate {
    func selectCorrectColorViewModelDidFinish(_ viewModel: SelectCorrectColorViewModel) {
        let selectWrongColorViewController = selectWrongColorVCFactory.selectWrongColorViewController(viewModelDelegate: self,
                                                                                                      correctColor: viewModel.correctColor,
                                                                                                      wrongColor: viewModel.wrongColor)
        
        view?.set(contentViewController: selectWrongColorViewController, isNavigatingForward: true)
    }
}

extension ChooseColorContentViewModelImpl: SelectWrongColorViewModelDelegate {
    func selectWrongColorViewModel(_ viewModel: SelectWrongColorViewModel,
                                   didFinishWithResult isSuccess: Bool) {
        stopTimer()
        
        guard let startDate = startDate else {
            let somethingWentWrongAlertVC = alertVCFactory.somethingWentWrongAlertViewController { [weak self] in
                self?.tryAgain()
            }
            
            view?.present(viewController: somethingWentWrongAlertVC)
            
            return
        }
        
        let timePassed = Date().timeIntervalSince(startDate)
        
        let finishAlertVC = alertVCFactory.chooseColorAlertViewController(isSuccess: isSuccess,
                                                                          inTime: timePassed) { [weak self] in
            self?.tryAgain()
        }
        
        view?.present(viewController: finishAlertVC)
    }
}
