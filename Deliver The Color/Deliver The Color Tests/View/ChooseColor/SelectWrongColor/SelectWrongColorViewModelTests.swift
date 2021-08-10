//
//  SelectWrongColorViewModelTests.swift
//  Deliver The Color Tests
//
//  Created by Dan Andoni on 10/08/2021.
//

import Foundation
import Quick
import Nimble

@testable import Deliver_The_Color

final class SelectWrongColorViewModelTests: QuickSpec {
    override func spec() {
        describe("SelectWrongColorViewModel") {
            var sut: SelectWrongColorViewModelImpl!
            var view: MockSelectWrongColorView!
            var delegate: MockSelectWrongColorViewModelDelegate!
            let correctColor: ColorItem = .magenta
            let wrongColor: ColorItem = .purple
            
            beforeEach {
                view = MockSelectWrongColorView()
                delegate = MockSelectWrongColorViewModelDelegate()
                sut = SelectWrongColorViewModelImpl(delegate: delegate,
                                                    correctColor: correctColor,
                                                    wrongColor: wrongColor)
                sut.bind(view: view)
            }
            
            context("when view did load") {
                beforeEach {
                    sut.viewDidLoad()
                }
                
                it("should set expected title for the top button") {
                    expect(view.setTopButtonTextParams?.0) == correctColor.rawValue
                }
                
                it("should set expected color for the top button") {
                    expect(view.setTopButtonTextParams?.1) == correctColor.color
                }
                
                it("should set expected title for the bottom button") {
                    expect(view.setBottomButtonTextParams?.0) == wrongColor.rawValue
                }
                
                it("should set expected color for the bottom button") {
                    expect(view.setBottomButtonTextParams?.1) == wrongColor.color
                }
            }
            
            context("when view did tap top button") {
                beforeEach {
                    sut.viewDidTapTopButton()
                }
                
                it("should tell the delegate the result is success") {
                    expect(delegate.selectWrongColorViewModelParams?.1) == true
                }
                
                it("should pass self as view model") {
                    expect(delegate.selectWrongColorViewModelParams?.0) === sut
                }
            }
            
            context("when view did tap bottom button") {
                beforeEach {
                    sut.viewDidTapBottomButton()
                }
                
                it("should tell the delegate the result is failure") {
                    expect(delegate.selectWrongColorViewModelParams?.1) == false
                }
                
                it("should pass self as view model") {
                    expect(delegate.selectWrongColorViewModelParams?.0) === sut
                }
            }
        }
    }
}
