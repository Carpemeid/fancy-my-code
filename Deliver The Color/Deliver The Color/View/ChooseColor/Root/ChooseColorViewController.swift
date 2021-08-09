//
//  ChooseColorViewController.swift
//  Deliver The Color
//
//  Created by Dan Andoni on 10/08/2021.
//

import UIKit

// protocol for hiding away the concrete type of the vc
// whoever wants to use the VC should only be able to access the functionality intently defined by us
// and not depend on the concrete implementation of the ChooseColorViewController
protocol ChooseColorView: AnyObject {
    func set(viewController: UIViewController,
             asNext isNext: Bool)
}

final class ChooseColorViewController: UIPageViewController {
    private let viewModel: ChooseColorViewModel
    
    init(viewModel: ChooseColorViewModel) {
        self.viewModel = viewModel
        super.init(transitionStyle: .scroll,
                   navigationOrientation: .horizontal,
                   options: nil)
    }
    
    @available(*, unavailable)
    init() {
        fatalError("not implemented")
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
}

extension ChooseColorViewController: ChooseColorView {
    func set(viewController: UIViewController, asNext isNext: Bool) {
        setViewControllers([viewController],
                           direction: isNext ? .forward : .reverse,
                           animated: true)
    }
}
