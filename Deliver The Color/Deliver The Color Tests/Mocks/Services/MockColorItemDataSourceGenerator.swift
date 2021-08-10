//
//  MockColorItemDataSourceGenerator.swift
//  Deliver The Color Tests
//
//  Created by Dan Andoni on 10/08/2021.
//

import Foundation

@testable import Deliver_The_Color

final class MockColorItemDataSourceGenerator: ColorItemDataSourceGenerator {
    var randomColorItemsToReturn: [ColorItem] = [.greeen, .blue]
    func randomColorItems() -> [ColorItem] {
        randomColorItemsToReturn
    }
}
