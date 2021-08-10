//
//  SelectCorrectColorViewController.swift
//  Deliver The Color
//
//  Created by Dan Andoni on 10/08/2021.
//

import UIKit

// service locator pattern for instance creation
protocol SelectCorrectColorViewControllerFactory {
    func selectCorrectColorViewController(viewModelDelegate: SelectCorrectColorViewModelDelegate,
                                            correctColor: ColorItem,
                                            wrongColor: ColorItem) -> UIViewController
}

// hides away the concrete type being injected
extension SelectCorrectColorViewControllerFactory {
    func selectCorrectColorViewController(viewModelDelegate: SelectCorrectColorViewModelDelegate,
                                            correctColor: ColorItem,
                                            wrongColor: ColorItem) -> UIViewController {
        let viewModel = SelectCorrectColorViewModelImpl(delegate: viewModelDelegate,
                                                          correctColor: correctColor,
                                                          wrongColor: wrongColor)
        let viewController = SelectCorrectColorViewController(viewModel: viewModel)
        
        viewModel.bind(view: viewController)
        
        return viewController
    }
}

protocol SelectCorrectColorView: AnyObject {
    var selectedRows: [Int]? { get }
    
    func set(title: NSAttributedString)
}

final class SelectCorrectColorViewController: UIViewController {
    private static let reuseIdentifier = "reuseIdentifier"
    private let viewModel: SelectCorrectColorViewModel
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    init(viewModel: SelectCorrectColorViewModel) {
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: SelectCorrectColorViewController.reuseIdentifier)
        viewModel.viewDidLoad()
    }
}

extension SelectCorrectColorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.colorCount()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectCorrectColorViewController.reuseIdentifier, for: indexPath)
        
        cell.backgroundColor = viewModel.backgroundColor(forIndex: indexPath.row)
        cell.textLabel?.text = viewModel.colorText(forIndex: indexPath.row)
        cell.textLabel?.textColor = .white
        
        return cell
    }
}

extension SelectCorrectColorViewController: UITableViewDelegate {
    // removes empty displayed cells outside datasource range
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.viewDidChangeSelection()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        viewModel.viewDidChangeSelection()
    }
}

extension SelectCorrectColorViewController: SelectCorrectColorView {
    func set(title: NSAttributedString) {
        titleLabel.attributedText = title
    }
    
    var selectedRows: [Int]? {
        tableView.indexPathsForSelectedRows?.compactMap { $0.row }
    }
}
