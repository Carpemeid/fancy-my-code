//
//  ChooseColorContentViewModelTests.swift
//  Deliver The Color Tests
//
//  Created by Dan Andoni on 10/08/2021.
//

import UIKit
import Quick
import Nimble

@testable import Deliver_The_Color

final class ChooseColorContentViewModelTests: QuickSpec {
    final class MockContainer: ChooseColorContentViewModelImpl.Container {
        var selectCorrectColorViewControllerParams: (viewModelDelegate: SelectCorrectColorViewModelDelegate,
                                                     correctColor: ColorItem,
                                                     wrongColor: ColorItem)?
        var selectCorrectColorViewControllerToReturn = UIViewController()
        func selectCorrectColorViewController(viewModelDelegate: SelectCorrectColorViewModelDelegate,
                                              correctColor: ColorItem,
                                              wrongColor: ColorItem) -> UIViewController {
            selectCorrectColorViewControllerParams = (viewModelDelegate, correctColor, wrongColor)
            return selectCorrectColorViewControllerToReturn
        }
        
        var colorItemDataSourceGeneratorToReturn = MockColorItemDataSourceGenerator()
        func colorItemDataSourceGenerator() -> ColorItemDataSourceGenerator {
            colorItemDataSourceGeneratorToReturn
        }
        
        var selectWrongColorViewControllerParams: (viewModelDelegate: SelectWrongColorViewModelDelegate,
                                                   correctColor: ColorItem,
                                                   wrongColor: ColorItem)?
        var selectWrongColorViewControllerToReturn = UIViewController()
        func selectWrongColorViewController(viewModelDelegate: SelectWrongColorViewModelDelegate,
                                            correctColor: ColorItem,
                                            wrongColor: ColorItem) -> UIViewController {
            selectWrongColorViewControllerParams = (viewModelDelegate, correctColor, wrongColor)
            return selectWrongColorViewControllerToReturn
        }
        
        var somethingWentWrongAlertViewControllerParam: (() -> Void)?
        var somethingWentWrongAlertViewControllerToReturn = UIViewController()
        func somethingWentWrongAlertViewController(completion: @escaping () -> Void) -> UIViewController {
            somethingWentWrongAlertViewControllerParam = completion
            return somethingWentWrongAlertViewControllerToReturn
        }
        
        var chooseColorAlertViewControllerParams: (isSuccess: Bool,
                                                   timeInterval: TimeInterval,
                                                   completion: () -> Void)?
        var chooseColorAlertViewControllerToReturn = UIViewController()
        func chooseColorAlertViewController(isSuccess: Bool,
                                            inTime timeInterval: TimeInterval,
                                            completion: @escaping () -> Void) -> UIViewController {
            chooseColorAlertViewControllerParams = (isSuccess, timeInterval, completion)
            return chooseColorAlertViewControllerToReturn
        }
    }
    
    override func spec() {
        describe("ChooseColorContentViewModel") {
            var sut: ChooseColorContentViewModelImpl!
            var container: MockContainer!
            var view: MockChooseColorContentView!
            
            beforeEach {
                container = MockContainer()
                view = MockChooseColorContentView()
                sut = ChooseColorContentViewModelImpl(container: container)
                sut.bind(view: view)
            }
            
            context("when view did load") {
                beforeEach {
                    sut.viewDidLoad()
                }
                
                it("should request select correct vc with expected delegate") {
                    expect(container.selectCorrectColorViewControllerParams?.viewModelDelegate) === sut
                }
                
                it("should request select correct vc with expected correct color") {
                    expect(container.selectCorrectColorViewControllerParams?.correctColor) == container.colorItemDataSourceGeneratorToReturn.randomColorItemsToReturn.first
                }
                
                it("should request select correct vc with expected wrong color") {
                    expect(container.selectCorrectColorViewControllerParams?.wrongColor) == container.colorItemDataSourceGeneratorToReturn.randomColorItemsToReturn.last
                }
                
                it("should set the expected content view controller") {
                    expect(container.selectCorrectColorViewControllerToReturn) === view.setContentViewControllerParams?.0
                }
            }
            
            context("when view did appear") {
                beforeEach {
                    sut.viewDidAppear()
                }
                
                it("should start the timer") {
                    expect(view.setTimeParam).toEventuallyNot(beNil())
                }
            }
            
            context("when select correct coller view model finishes") {
                var selectCorrectColorViewModel: MockSelectCorrectColorViewModel!
                
                beforeEach {
                    selectCorrectColorViewModel = MockSelectCorrectColorViewModel()
                    
                    sut.selectCorrectColorViewModelDidFinish(selectCorrectColorViewModel)
                }
                
                it("should request select wrong vc with expected delegate") {
                    expect(container.selectWrongColorViewControllerParams?.viewModelDelegate) === sut
                }
                
                it("should request select wrong vc with expected correct color") {
                    expect(container.selectWrongColorViewControllerParams?.correctColor) == selectCorrectColorViewModel.correctColor
                }
                
                it("should request select wrong vc with expected wrong color") {
                    expect(container.selectWrongColorViewControllerParams?.wrongColor) == selectCorrectColorViewModel.wrongColor
                }
                
                it("should set the expected content view controller") {
                    expect(container.selectWrongColorViewControllerToReturn) === view.setContentViewControllerParams?.0
                }
            }
            
            context("when select wrong view model finishes") {
                var selectWrongColorViewModel: MockSelectWrongColorViewModel!
                
                beforeEach {
                    selectWrongColorViewModel = MockSelectWrongColorViewModel()
                }
                
                context("when it finishes with failure") {
                    beforeEach {
                        sut.viewDidAppear()
                        view.setTimeParam = nil
                        sut.selectWrongColorViewModel(selectWrongColorViewModel,
                                                      didFinishWithResult: false)
                        
                    }
                    
                    it("should not update timer") {
                        expect(view.setTimeParam).toEventually(beNil())
                    }
                    
                    it("should pass expected success value") {
                        expect(container.chooseColorAlertViewControllerParams?.isSuccess) == false
                    }
                    
                    it("should present expected alert vc") {
                        expect(view.presentParam) === container.chooseColorAlertViewControllerToReturn
                    }
                    
                    it("should present an alert with a time interval") {
                        expect(container.chooseColorAlertViewControllerParams?.timeInterval).to(beGreaterThan(0))
                    }
                    
                    context("when user taps try again") {
                        beforeEach {
                            view.setTimeParam = nil
                            container.chooseColorAlertViewControllerParams?.completion()
                        }
                        
                        it("should start the timer") {
                            expect(view.setTimeParam).toEventuallyNot(beNil())
                        }
                        
                        it("should request select correct vc with expected delegate") {
                            expect(container.selectCorrectColorViewControllerParams?.viewModelDelegate) === sut
                        }
                        
                        it("should request select correct vc with expected correct color") {
                            expect(container.selectCorrectColorViewControllerParams?.correctColor) == container.colorItemDataSourceGeneratorToReturn.randomColorItemsToReturn.first
                        }
                        
                        it("should request select correct vc with expected wrong color") {
                            expect(container.selectCorrectColorViewControllerParams?.wrongColor) == container.colorItemDataSourceGeneratorToReturn.randomColorItemsToReturn.last
                        }
                        
                        it("should set the expected content view controller") {
                            expect(container.selectCorrectColorViewControllerToReturn) === view.setContentViewControllerParams?.0
                        }
                    }
                }
                
                context("when it finishes with success") {
                    beforeEach {
                        sut.viewDidAppear()
                        view.setTimeParam = nil
                        sut.selectWrongColorViewModel(selectWrongColorViewModel,
                                                      didFinishWithResult: true)
                    }
                    
                    it("should not update timer") {
                        expect(view.setTimeParam).toEventually(beNil())
                    }
                    
                    it("should pass expected success value") {
                        expect(container.chooseColorAlertViewControllerParams?.isSuccess) == true
                    }
                    
                    it("should present expected alert vc") {
                        expect(view.presentParam) === container.chooseColorAlertViewControllerToReturn
                    }
                    
                    it("should present an alert with a time interval") {
                        expect(container.chooseColorAlertViewControllerParams?.timeInterval).to(beGreaterThan(0))
                    }
                    
                    context("when user taps try again") {
                        beforeEach {
                            view.setTimeParam = nil
                            container.chooseColorAlertViewControllerParams?.completion()
                        }
                        
                        it("should start the timer") {
                            expect(view.setTimeParam).toEventuallyNot(beNil())
                        }
                        
                        it("should request select correct vc with expected delegate") {
                            expect(container.selectCorrectColorViewControllerParams?.viewModelDelegate) === sut
                        }
                        
                        it("should request select correct vc with expected correct color") {
                            expect(container.selectCorrectColorViewControllerParams?.correctColor) == container.colorItemDataSourceGeneratorToReturn.randomColorItemsToReturn.first
                        }
                        
                        it("should request select correct vc with expected wrong color") {
                            expect(container.selectCorrectColorViewControllerParams?.wrongColor) == container.colorItemDataSourceGeneratorToReturn.randomColorItemsToReturn.last
                        }
                        
                        it("should set the expected content view controller") {
                            expect(container.selectCorrectColorViewControllerToReturn) === view.setContentViewControllerParams?.0
                        }
                    }
                }
            }
        }
    }
}
