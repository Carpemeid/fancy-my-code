//
//  MockSelectCorrectColorView.swift
//  Deliver The Color Tests
//
//  Created by Dan Andoni on 10/08/2021.
//

import Foundation
@testable import Deliver_The_Color

final class MockSelectCorrectColorView: SelectCorrectColorView {
    var selectedRowsToReturn: [Int]?
    var selectedRows: [Int]? {
        selectedRowsToReturn
    }
    
    var setTitleParam: NSAttributedString?
    func set(title: NSAttributedString) {
        setTitleParam = title
    }
}
