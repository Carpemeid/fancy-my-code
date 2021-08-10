//
//  MockSelectWrongColorViewModelDelegate.swift
//  Deliver The Color Tests
//
//  Created by Dan Andoni on 10/08/2021.
//

import Foundation
@testable import Deliver_The_Color

final class MockSelectWrongColorViewModelDelegate: SelectWrongColorViewModelDelegate {
    var selectWrongColorViewModelParams: (SelectWrongColorViewModel, Bool)?
    func selectWrongColorViewModel(_ viewModel: SelectWrongColorViewModel,
                                   didFinishWithResult isSuccess: Bool) {
        selectWrongColorViewModelParams = (viewModel, isSuccess)
    }
}
