//
//  CoorinateCalculatorUnitTest.swift
//  CoorinateCalculatorUnitTest
//
//  Created by Choi Jeong Hoon on 2017. 11. 28..
//  Copyright © 2017년 Codesquad Inc. All rights reserved.
//

import XCTest
@testable import CoordinateCalculator

class CoorinateCalculatorUnitTest: XCTestCase {
    // 숫자가 아닌 다른 문자가 들어왔을때의 에러가 정상적으로 에러 체크 되는가
    func testcheckIsSupportedValuesMethod () {
        let unSupportedValue = "(aa,gg)-(ㄹㄹ-20)-(11,15)"
        XCTAssertThrowsError(try SyntaxChecker().getErrorChekcedValue(unSupportedValue)) { (error) -> Void in
            XCTAssertEqual(error as? SyntaxChecker.ErrorMessage , SyntaxChecker.ErrorMessage.ofValueIsNotInt)
        }
    }
    
    // 괄호가 없이 입력되었을때의 에러가 정상적으로 에러체크 되는가
    func testErrorOfNoParenthesis () {
        let withoutParenthesis = "(15,25-12-20)-(11,15)"
        XCTAssertThrowsError(try SyntaxChecker().getErrorChekcedValue(withoutParenthesis)) { (error) -> Void in
            XCTAssertEqual(error as? SyntaxChecker.ErrorMessage , SyntaxChecker.ErrorMessage.ofNonexistentParenthesis)
        }
    }
    
    // 콤마가 없을때의 에러가 정상적으로 출력되는가
    func testErrorOfNoComma () {
        let withoutComma = "(2410)-(15,10)-(7,6)"
        XCTAssertThrowsError(try SyntaxChecker().getErrorChekcedValue(withoutComma)) { (error) -> Void in
            XCTAssertEqual(error as? SyntaxChecker.ErrorMessage , SyntaxChecker.ErrorMessage.ofNonexistenceComma)
        }
    }
    
    // 지정한 범위 24를 초과시의 에러가 정상적으로 에러체크 되는가
    func testErrorOfExceedValidInput () {
        let exceedNum = "(15,25)-(12,20)-(11,15)"
        XCTAssertThrowsError(try SyntaxChecker().getErrorChekcedValue(exceedNum)) { (error) -> Void in
            XCTAssertEqual(error as? SyntaxChecker.ErrorMessage , SyntaxChecker.ErrorMessage.ofExceedValidInput)
        }
    }
    
    
    // 같은 좌표 입력시 직선생성 에러가 정상적으로 에러체크 되는가
    func testErrorOfSameCoordinatesInLine () {
        let sameCoords = "(24,10)-(24,10)"
        let samecoord =  try! SyntaxChecker().getErrorChekcedValue(sameCoords)
        let myShape = ShapeFactory()
        XCTAssertThrowsError(try myShape.makeShapeInstance(samecoord))
    }
    
    // 같은 좌표 입력시 삼각형생성 에러가 정상적으로 에러체크 되는가
    func testErrorOfSameCoordinatesInTriangle () {
        let sameCoords = "(24,10)-(16,19)-(24,10)"
        let samecoord =  try! SyntaxChecker().getErrorChekcedValue(sameCoords)
        let myShape = ShapeFactory()
        XCTAssertThrowsError(try myShape.makeShapeInstance(samecoord))
    }
    
    // 위아래 변의 길이가 같지 않을때 사각형생성 에러가 정상적으로 에러체크 되는가
    func testErrorSameLengthOfTopBottomSide () {
        let notEqualInLength = "(5,5)-(20,5)-(20,16)-(5,18)"
        let unequalInLength =  try! SyntaxChecker().getErrorChekcedValue(notEqualInLength)
        let myShape = ShapeFactory()
        XCTAssertThrowsError(try myShape.makeShapeInstance(unequalInLength))
    }
    
    // 정상좌표 입력시 shape(라인)인스턴스가 생성되는가
    func testIsSuccessMakingMyPointInstance () {
        let valinInputValue = "(24,10)-(15,10)"
        let instanceOfMyPoint = try! SyntaxChecker().getErrorChekcedValue(valinInputValue)
        XCTAssertNotNil(instanceOfMyPoint)
    }
    
    // 정상좌표 입력시 인스턴스가 생성되는가
    func testIsSuccessMakingMyShapeInstance () {
        let valinInputValue = "(5,5)-(20,5)-(20,18)-(5,18)"
        let valinInput =  try! SyntaxChecker().getErrorChekcedValue(valinInputValue)
        let myShape = ShapeFactory()
        let instanceOfMyShape = try! myShape.makeShapeInstance(valinInput)
        XCTAssertNotNil(instanceOfMyShape)
    }
 
}
