//
//  ColorItemDataSourceGenerator.swift
//  Deliver The Color
//
//  Created by Dan Andoni on 10/08/2021.
//

import Foundation

// service locator pattern for instance creation
protocol ColorItemDataSourceGeneratorFactory {
    func colorItemDataSourceGenerator() -> ColorItemDataSourceGenerator
}

// default implementation for service locator pattern
// hides away the concrete type being injected
extension ColorItemDataSourceGeneratorFactory {
    func colorItemDataSourceGenerator() -> ColorItemDataSourceGenerator {
        return ColorItemDataSourceGeneratorImpl()
    }
}

protocol ColorItemDataSourceGenerator {
    func randomColorItems() -> [ColorItem]
}

final class ColorItemDataSourceGeneratorImpl: ColorItemDataSourceGenerator {
    func randomColorItems() -> [ColorItem] {
        let shuffledColors = ColorItem.allCases.shuffled()
        
        return [shuffledColors[0], shuffledColors[1]]
    }
}
