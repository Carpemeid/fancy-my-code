//
//  MockSelectCorrectColorViewModel.swift
//  Deliver The Color Tests
//
//  Created by Dan Andoni on 10/08/2021.
//

import UIKit
@testable import Deliver_The_Color

final class MockSelectCorrectColorViewModel: SelectCorrectColorViewModel {
    var correctColorToReturn: ColorItem = .blue
    var correctColor: ColorItem { correctColorToReturn }
    var wrongColorToReturn: ColorItem = .cyan
    var wrongColor: ColorItem { wrongColorToReturn }
    
    func viewDidLoad() {}
    
    var colorCountToReturn = 3
    func colorCount() -> Int {colorCountToReturn}
    
    var backgroundColorToReturn: UIColor = .blue
    var backgroundColorParam: Int?
    func backgroundColor(forIndex index: Int) -> UIColor {
        backgroundColorParam = index
        return backgroundColorToReturn
    }
    
    var colorTextToReturn = "asd"
    var colorTextParam: Int?
    func colorText(forIndex index: Int) -> String {
        colorTextParam = index
        return colorTextToReturn
    }
    
    func viewDidChangeSelection() {}
}
