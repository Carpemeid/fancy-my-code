//
//  MockSelectCorrectColorViewModelDelegate.swift
//  Deliver The Color Tests
//
//  Created by Dan Andoni on 10/08/2021.
//

import Foundation
@testable import Deliver_The_Color

final class MockSelectCorrectColorViewModelDelegate: SelectCorrectColorViewModelDelegate {
    var selectCorrectColorViewModelDidFinishParam: SelectCorrectColorViewModel?
    func selectCorrectColorViewModelDidFinish(_ viewModel: SelectCorrectColorViewModel) {
        selectCorrectColorViewModelDidFinishParam = viewModel
    }
}
