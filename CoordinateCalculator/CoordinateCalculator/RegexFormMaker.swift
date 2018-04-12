//
//  RegexMaker.swift
//  CoordinateCalculator
//
//  Created by Yoda Codd on 2018. 4. 12..
//  Copyright © 2018년 Codesquad Inc. All rights reserved.
//

import Foundation
/// 정규식을 만드는 구조체
struct RegexFormMaker {
    /// 입력한 문자열로 정규식을 만들어주는 함수
    static func makeRegexForm(regexTry : String)->NSRegularExpression?{
        return try? NSRegularExpression(pattern: regexTry, options: []) else {
            print("잘못된 정규식 표현입니다")
            return nil
        }
    }    
}
