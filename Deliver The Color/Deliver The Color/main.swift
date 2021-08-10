//
//  main.swift
//  Deliver The Color
//
//  Created by Dan Andoni on 10/08/2021.
//

import UIKit

class TestingAppDelegate: UIResponder {}

let isRunningTests = NSClassFromString("XCTestCase") != nil

let appDelegateClass : AnyClass = isRunningTests ? TestingAppDelegate.self: AppDelegate.self
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appDelegateClass))
