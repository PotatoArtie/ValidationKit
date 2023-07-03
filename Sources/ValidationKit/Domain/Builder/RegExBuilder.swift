//
//  File.swift
//  
//
//  Created by Dongju on 2023/06/21.
//

import Foundation

public final class RegExBuilder: Builder {
    var requiredInclude = [RegExType]()
    var regEx = [RegExType]()
    var min: Int = 8
    var max: Int = 20
    var specialSymbols: String = ""
    var logOption: LogOptions = .default
    
    public init(){}
    
    /// 필수로 포함시켜야할 문자를 설정할 수 있습니다.
    /// - Parameter type: 영어,한글,숫자,특수문자 값을 추가
    /// - Returns: RegExBuilder
    public func required(_ type: [RegExType]) -> RegExBuilder {
        self.requiredInclude = type
        return self
    }
    
    ///  최소 최대길이를 설정할 수 있습니다.
    /// - Parameters:
    ///   - min: 최소길이
    ///   - max:  최대길이
    /// - Returns: RegExBuilder
    public func setLength(min: Int, max: Int) -> RegExBuilder{
        self.min = min
        self.max = max
        return self
    }
    
    ///  포함시켜야할 문자를 설정할 수 있습니다.
    /// - Parameter regEx: 영어,한글,숫자,특수문자 값을 추가
    /// - Returns: RegExBuilder
    public func setRegex(_ regEx: [RegExType]) -> RegExBuilder {
        self.regEx = regEx
        return self
    }
    
    /// 로그옵션을 설정할 수 있습니다.  LogOptions.verbose 옵션을 지정하여 상세한 로그가 확인 가능합니다.
    /// 예시 >>  setLogOption(.verbose)
    /// - Parameter option: default , verbose 옵션 선택 가능
    /// - Returns: RegExBuilder
    public func setLogOption(_ option: LogOptions) -> RegExBuilder {
        self.logOption = option
        return self
    }
    
    /// 특수문자를 설정할 수 있습니다. #"{YOUR SPECIAL SYMBOLS}"# 형식에 맞춰서 넣어 사용해주세요.
    /// - Parameter specialSymbols: 예시 >>> #",<.>\/?;:'"\[{\]}`~₩!@#$%^&*()-_=+\|"#)
    /// - Returns:  RegExBuilder
    public func setSpecialCharacter(_ specialSymbols: String) -> RegExBuilder {
        self.specialSymbols = specialSymbols.replacingOccurrences(of: "#\"", with: "").replacingOccurrences(of: "\"#", with: "").reduce("", { partialResult, item in
            return partialResult+"\\\(item)"
        })
        return self
    }
    
    /// 조건에 맞는  STValidator를 생성합니다.
    /// - Returns: STValidator
    public func build() ->  STValidator {
        if requiredInclude.contains(.specialSymbols) && self.specialSymbols.isEmpty {
            self.specialSymbols = RegExType.specialSymbols.rawValue
        }
        
        print("self.requiredInclude.isEmpty && self.regEx.isEmpty \(self.requiredInclude.isEmpty && self.regEx.isEmpty )")
        
        return STValidator( requiredInclude: self.requiredInclude, regEx: self.regEx, min: self.min, max: self.max, specialSymbols: self.specialSymbols, logOption: self.logOption)
    }
    
//    func error(){
//            #error("둘 중 하나는 설정해야합니다.")
//    }
}

