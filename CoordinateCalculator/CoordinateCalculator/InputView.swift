//
//  InputView.swift
//  CoordinateCalculator
//
//  Created by Daheen Lee on 22/04/2019.
//  Copyright © 2019 Codesquad Inc. All rights reserved.
//

import Foundation

enum InputError: Error {
    case whileReadingInput
    case invalidParenthesis
    case invalidNumber
}

struct InputView {
    static public func readInput() throws -> MyPoint {
        var point: MyPoint!
        let question = "좌표를 입력하세요: "
        repeat {
            print(question)
            guard let input = readLine(), isValid(input) else {
                throw InputError.whileReadingInput
            }
            point = try parseIntoPoint(using: input)
        } while(isPointOutOfAxis(using: point))
        
        return point
    }
    
    static private func isValid(_ input: String) -> Bool {
        return input.contains("(") && input.contains(")") && input.count >= 5 && !input.isEmpty
    }
    
    static private func parseIntoPoint(using input: String) throws -> MyPoint {
        let blankRemovedInput = input.replacingOccurrences(of: " ", with: "")
        guard let inputWithoutParenthesis = unwrapParenthesis(of: blankRemovedInput) else {
            throw InputError.invalidParenthesis
        }
        guard let (numX, numY) = divideNumbers(from: inputWithoutParenthesis) else {
            throw InputError.invalidNumber
        }
        return MyPoint(x: numX, y: numY)
    }
    
    static private func unwrapParenthesis(of input: String) -> String? {
        guard let openParenthesisIndex = input.index(of: "(") else { return nil }
        guard let closeParenthesisIndex = input.index(of: ")") else { return nil }
        let startIndexOfNum = input.index(openParenthesisIndex, offsetBy: 1)
        let endIndexOfNum = input.index(closeParenthesisIndex, offsetBy: -1)
        return String(input[startIndexOfNum...endIndexOfNum])
    }
    
    static private func divideNumbers(from input: String) -> (Int, Int)? {
        let dividedByComma = input.components(separatedBy: ",")
        if dividedByComma.count != 2 {
            return nil
        }
        guard let convertedX = Int(dividedByComma[0]) else { return nil }
        guard let convertedY = Int(dividedByComma[1]) else { return nil }
        return (convertedX, convertedY)
    }
    
    static private func isPointOutOfAxis(using point: MyPoint) -> Bool {
        return point.x > ANSICode.axis.AxisLimit || point.y > ANSICode.axis.AxisLimit || point.x < 0 || point.y < 0
    }
}
