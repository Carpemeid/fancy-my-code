//
//  MockSelectWrongColorView.swift
//  Deliver The Color Tests
//
//  Created by Dan Andoni on 10/08/2021.
//

import UIKit
@testable import Deliver_The_Color

final class MockSelectWrongColorView: SelectWrongColorView {
    var setTopButtonTextParams: (String, UIColor)?
    func setTopButtonText(_ text: String, color: UIColor) {
        setTopButtonTextParams = (text, color)
    }
    
    var setBottomButtonTextParams: (String, UIColor)?
    func setBottomButtonText(_ text: String, color: UIColor) {
        setBottomButtonTextParams = (text, color)
    }
}
