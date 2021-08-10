//
//  SelectCorrectColorViewModel.swift
//  Deliver The Color
//
//  Created by Dan Andoni on 10/08/2021.
//

import UIKit

protocol SelectCorrectColorViewModelDelegate: AnyObject {
    func selectCorrectColorViewModelDidFinish(_ viewModel: SelectCorrectColorViewModel)
}

protocol SelectCorrectColorViewModel {
    var correctColor: ColorItem { get }
    var wrongColor: ColorItem { get }
    
    func viewDidLoad()
    func colorCount() -> Int
    func backgroundColor(forIndex index: Int) -> UIColor
    func colorText(forIndex index: Int) -> String
    func viewDidChangeSelection()
}

final class SelectCorrectColorViewModelImpl: SelectCorrectColorViewModel {
    private static let numberOfRows = 4
    
    private weak var delegate: SelectCorrectColorViewModelDelegate?
    private weak var view: SelectCorrectColorView?
    
    let correctColor: ColorItem
    let wrongColor: ColorItem
    
    private lazy var colors: [ColorItem] = {
        let wrongColorsCount = Int.random(in: 1..<SelectCorrectColorViewModelImpl.numberOfRows - 1)
        let wrongColors = Array(repeating: wrongColor, count: wrongColorsCount)
        let correctColors = Array(repeating: correctColor, count: SelectCorrectColorViewModelImpl.numberOfRows - wrongColorsCount)
        
        return (wrongColors + correctColors).shuffled()
    }()
    
    private lazy var expectedCorrectRows: [Int] = {
        colors.lazy.enumerated().filter { $0.element == correctColor }.compactMap { $0.offset }
    }()
    
    init(delegate: SelectCorrectColorViewModelDelegate,
         correctColor: ColorItem,
         wrongColor: ColorItem) {
        self.delegate = delegate
        self.correctColor = correctColor
        self.wrongColor = wrongColor
    }
    
    func bind(view: SelectCorrectColorView) {
        self.view = view
    }
    
    func viewDidLoad() {
        configureTitle()
    }
    
    private func configureTitle() {
        let titleText = "Select the \(correctColor.rawValue) color"
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributedString = NSMutableAttributedString(string: titleText, attributes: [.paragraphStyle: paragraphStyle])
        
        guard let titleTextRange = titleText.range(of: correctColor.rawValue) else {
            return
        }
        
        let nsRange = NSRange(titleTextRange, in: titleText)
        
        attributedString.addAttributes([.foregroundColor: correctColor.color], range: nsRange)
        
        view?.set(title: attributedString)
    }
    
    func colorCount() -> Int {
        colors.count
    }
    
    func backgroundColor(forIndex index: Int) -> UIColor {
        colors[index].color
    }
    
    func colorText(forIndex index: Int) -> String {
        return colors[index].rawValue
    }
    
    func viewDidChangeSelection() {
        guard let viewSelectedRows = view?.selectedRows else {
            return
        }
        
        guard expectedCorrectRows.allSatisfy(viewSelectedRows.contains),
              viewSelectedRows.count == expectedCorrectRows.count else {
            return
        }
        
        delegate?.selectCorrectColorViewModelDidFinish(self)
    }
}
