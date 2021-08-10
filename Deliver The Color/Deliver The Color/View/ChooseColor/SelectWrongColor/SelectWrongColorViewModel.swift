//
//  SelectWrongColorViewModel.swift
//  Deliver The Color
//
//  Created by Dan Andoni on 10/08/2021.
//

import Foundation

protocol SelectWrongColorViewModelDelegate: AnyObject {
    func selectWrongColorViewModel(_ viewModel: SelectWrongColorViewModel,
                                   didFinishWithResult isSuccess: Bool)
}

protocol SelectWrongColorViewModel {
    func viewDidLoad()
    
    // could've been done with a tableview
    // but had to wrap it up fast
    func viewDidTapTopButton()
    func viewDidTapBottomButton()
}

final class SelectWrongColorViewModelImpl: SelectWrongColorViewModel {
    private weak var delegate: SelectWrongColorViewModelDelegate?
    private weak var view: SelectWrongColorView?
    private let correctColor: ColorItem
    private let wrongColor: ColorItem
    
    init(delegate: SelectWrongColorViewModelDelegate,
         correctColor: ColorItem,
         wrongColor: ColorItem) {
        self.delegate = delegate
        self.correctColor = correctColor
        self.wrongColor = wrongColor
    }
    
    func bind(view: SelectWrongColorView) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.setTopButtonText(correctColor.rawValue, color: correctColor.color)
        view?.setBottomButtonText(wrongColor.rawValue, color: wrongColor.color)
    }
    
    func viewDidTapTopButton() {
        delegate?.selectWrongColorViewModel(self, didFinishWithResult: true)
    }
    
    func viewDidTapBottomButton() {
        delegate?.selectWrongColorViewModel(self, didFinishWithResult: false)
    }
}
