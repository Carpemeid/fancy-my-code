//
//  SelectCorrectColorViewModelTests.swift
//  Deliver The Color Tests
//
//  Created by Dan Andoni on 10/08/2021.
//

import Foundation
import Quick
import Nimble

@testable import Deliver_The_Color

final class SelectCorrectColorViewModelTests: QuickSpec {
    override func spec() {
        describe("SelectCorrectColorViewModel") {
            var sut: SelectCorrectColorViewModelImpl!
            var view: MockSelectCorrectColorView!
            var delegate: MockSelectCorrectColorViewModelDelegate!
            let correctColor: ColorItem = .red
            let wrongColor: ColorItem = .greeen
            
            beforeEach {
                view = MockSelectCorrectColorView()
                delegate = MockSelectCorrectColorViewModelDelegate()
                sut = SelectCorrectColorViewModelImpl(delegate: delegate,
                                                      correctColor: correctColor,
                                                      wrongColor: wrongColor)
                sut.bind(view: view)
            }
            
            context("when view did load") {
                beforeEach {
                    sut.viewDidLoad()
                }
                
                it("should set expected title") {
                    expect(view.setTitleParam?.string) == "Select the \(correctColor.rawValue) color"
                }
            }
            
            context("when color count is requested") {
                it("should return 4") {
                    expect(sut.colorCount()) == 4
                }
            }
            
            context("when background color for index is requested") {
                it("should return valid color") {
                    let color = sut.backgroundColor(forIndex: 0)
                    
                    expect(ColorItem.allCases.compactMap { $0.color }).to(contain(color))
                    
                }
            }
            
            context("when color text for index is requested") {
                it("should return valid text") {
                    let colorText = sut.colorText(forIndex: 0)
                    
                    expect(ColorItem.allCases.compactMap { $0.rawValue }).to(contain(colorText))
                }
            }
            
            context("when view did change selection") {
                context("when not all correct colors selected") {
                    beforeEach {
                        // assign to view all correct indexes except for one
                        view.selectedRowsToReturn = (0...3).filter { sut.backgroundColor(forIndex: $0) == sut.correctColor.color }.dropLast()
                        
                        sut.viewDidChangeSelection()
                    }
                    
                    it("should not call the delegate") {
                        expect(delegate.selectCorrectColorViewModelDidFinishParam).to(beNil())
                    }
                }
                
                context("when all correct colors selected but also wrong ones") {
                    beforeEach {
                        // assign to view all correct indexes except for one
                        let wrongColorIndex = (0...3).filter { sut.backgroundColor(forIndex: $0) == sut.wrongColor.color }.first
                        
                        view.selectedRowsToReturn = (0...3).filter { sut.backgroundColor(forIndex: $0) == sut.correctColor.color }
                        view.selectedRowsToReturn?.append(wrongColorIndex!)
                        
                        sut.viewDidChangeSelection()
                    }
                    
                    it("should not call the delegate") {
                        expect(delegate.selectCorrectColorViewModelDidFinishParam).to(beNil())
                    }
                }
                
                context("when all correct colors selected") {
                    beforeEach {
                        view.selectedRowsToReturn = (0...3).filter { sut.backgroundColor(forIndex: $0) == sut.correctColor.color }
                        
                        sut.viewDidChangeSelection()
                    }
                    
                    it("should call the delegate with self") {
                        expect(delegate.selectCorrectColorViewModelDidFinishParam) === sut
                    }
                }
            }
        }
    }
}
