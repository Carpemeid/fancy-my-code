//
//  SelectWrongColorViewController.swift
//  Deliver The Color
//
//  Created by Dan Andoni on 10/08/2021.
//

import UIKit

protocol SelectWrongColorViewControllerFactory {
    func selectWrongColorViewController(viewModelDelegate: SelectWrongColorViewModelDelegate,
                                        correctColor: ColorItem,
                                        wrongColor: ColorItem) -> UIViewController
}

extension SelectWrongColorViewControllerFactory {
    func selectWrongColorViewController(viewModelDelegate: SelectWrongColorViewModelDelegate,
                                        correctColor: ColorItem,
                                        wrongColor: ColorItem) -> UIViewController {
        let viewModel = SelectWrongColorViewModelImpl(delegate: viewModelDelegate,
                                                      correctColor: correctColor,
                                                      wrongColor: wrongColor)
        
        let viewController = SelectWrongColorViewController(viewModel: viewModel)
        
        viewModel.bind(view: viewController)
        
        return viewController
    }
}

protocol SelectWrongColorView: AnyObject {
    func setTopButtonText(_ text: String, color: UIColor)
    func setBottomButtonText(_ text: String, color: UIColor)
}

final class SelectWrongColorViewController: UIViewController {
    private let viewModel: SelectWrongColorViewModel
    
    @IBOutlet private weak var topButton: UIButton!
    @IBOutlet private weak var bottomButton: UIButton!
    
    init(viewModel: SelectWrongColorViewModel) {
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
    
    @IBAction func didTapTopButton(_ sender: UIButton) {
        viewModel.viewDidTapTopButton()
    }
    
    @IBAction func didTapBottomButton(_ sender: UIButton) {
        viewModel.viewDidTapBottomButton()
    }
}

extension SelectWrongColorViewController: SelectWrongColorView {
    func setTopButtonText(_ text: String, color: UIColor) {
        topButton.backgroundColor = color
        topButton.setTitle(text, for: .normal)
    }
    
    func setBottomButtonText(_ text: String, color: UIColor) {
        bottomButton.backgroundColor = color
        bottomButton.setTitle(text, for: .normal)
    }
}
