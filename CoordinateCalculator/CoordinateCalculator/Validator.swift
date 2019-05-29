//
//  Validator.swift
//  CoordinateCalculator
//
//  Created by 이희찬 on 21/05/2019.
//  Copyright © 2019 Codesquad Inc. All rights reserved.
//

import Foundation

struct Validator:Validatable {
    
    func isContainPointSeparator(_ userInput:String) -> Bool {
        let convertedInputToCharacterSet = CharacterSet(charactersIn: userInput)
        return FormatItem.pointSeparator.subtracting(convertedInputToCharacterSet).isEmpty
    }
    
    func isContainPointFormat(_ userInput:String) throws {
        let convertedInputToCharacterSet = CharacterSet(charactersIn: userInput)
        let coordinateFormatItem = FormatItem.coordinateContainer.union(FormatItem.coordinateItemSeparator).union(CharacterSet.decimalDigits)
        guard convertedInputToCharacterSet.subtracting(coordinateFormatItem).isEmpty else{
            throw UserInputError.inCorrectFormat
        }
    }
    
    func isCorrectFormat(_ userInput:String) throws {
        guard userInput.hasPrefix(FormatItem.coordinateContainerLeft) && userInput.hasSuffix(FormatItem.coordinateContainerRight) else{
            throw UserInputError.inCorrectFormat
        }
    }
    
    func isBelowFourPoint(_ seperatedInput:[String]) throws {
        guard seperatedInput.count < 5 else{
            throw UserInputError.inCorrectFormat
        }
    }
    
    func hasTwoItem(_ seperatedUserInput:[String]) throws {
        guard seperatedUserInput.count == 2 else{
            throw UserInputError.inCorrectItemNumber
        }
    }
    
    func coordinateIsInRange(_ point:(Int,Int)) throws {
        try isInRange(point.0)
        try isInRange(point.1)
    }
    
    func isInRange(_ point: Int) throws {
        let range = 0...ANSICode.axis.AxisLimit
        guard range.contains(point) else {
            throw UserInputError.outOfRange
        }
    }
    
    static func isRectangle(points: [coordinate]) throws {
        if points.count == 4 {
            try isRectangle(points: points)
        }
    }
    
    static func canDrawRect(points: [coordinate]) throws {
        var xSet: Set<Int> = []
        var ySet: Set<Int> = []
        
        for point in points {
            xSet.insert(point.0)
            ySet.insert(point.1)
        }
        guard xSet.count == 2 && ySet.count == 2 else {
            throw UserInputError.isNotRect
        }
    }
    
}
