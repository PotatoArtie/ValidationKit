//
//  RegExMatchedError.swift
//  
//
//  Created by Dongju on 2023/06/21.
//

import Foundation

public enum RegExMatchedError: String, Error {
    case notMatched = "조건에 일치하지 않습니다"
    case notContainedEnglish = "영어가 포함되어 있지 않습니다"
    case notContainedNumber = "숫자가 포함되어 있지 않습니다"
    case notContainedKorean = "한글이 포함되어 있지 않습니다"
    case notContainedSpecialSymbols = "특수문자가 포함되어 있지 않습니다"
    case invalidMin = "최소길이 조건에 일치하지 않습니다"
    case invalidMax = "최대길이 조건에 일치하지 않습니다."

    public var desc: String {
        self.rawValue
    }
}
