//
//  STValidator.swift
//  
//
//  Created by Dongju on 2023/06/21.
//

import Foundation

public final class STValidator {
    private var requiredInclude: [RegExType]
    private var regEx: [RegExType]
    private var min: Int
    private var max: Int
    private var specialSymbols: String
    private var logOption: LogOptions
    
    init(requiredInclude: [RegExType], regEx: [RegExType], min: Int, max: Int , specialSymbols: String , logOption: LogOptions) {
        self.requiredInclude = requiredInclude
        self.regEx = regEx
        self.min = min
        self.max = max
        self.specialSymbols = specialSymbols
        self.logOption = logOption
        
        if logOption == .verbose {
            print("### location \(#fileID) \n### line : \(#line) :: requiredInclude: \(self.requiredInclude)")
            print("### line : \(#line) :: regEx: \(self.regEx)")
            print("### line : \(#line) :: min :\(self.min) max: \(self.max)")
            print("### line : \(#line) :: specialSymbols\(self.specialSymbols.isEmpty ? "<<EMPTY>>" : self.specialSymbols)")
        }
    }
    
    
    /// 필수로 포함시켜야할 정규식을 확인합니다.
    /// - Parameter types: 영어,한글,숫자,특수문자 값을 추가
    /// - Returns: 추가한 문자열을 리턴합니다. 예시 >>> "(?=.*[{value})])"
    private func getRequiredIncludeString(_ types: [RegExType]) -> String {
        return self.requiredInclude.reduce("") { partialResult, item in
            partialResult + "(?=.*[\(item.desc)])"
        }
    }
    
    /// 필수로 포함시켜야할 정규식을 확인합니다.
    /// - Parameter types: 영어,한글,숫자,특수문자 값을 추가
    /// - Returns: 추가한 문자열을 리턴합니다.
    private func getRegExString(_ types: [RegExType]) -> String {
        return  regEx.reduce("") { partialResult, item in
            partialResult + "\(item.desc)"
        }
    }
    
    /// 키스텀한 정규표현식을 확인합니다.
    /// - Returns: 추가한 정규표현식의 문자열을 리턴합니다. 예시 >>> ^(?=.*[0-9])([a-zA-Z0-9\,\<\.\>\\\/\?\;\:\'\"\\\[\{\\\]\}\`\~\₩\!\@\#\$\%\^\&\*\(\)\-\_\=\+\\\|]{8,20})$)
    private func getCustomRegEx() -> String {
        
        if regEx.isEmpty && self.specialSymbols.isEmpty {
            return "^\(self.getRequiredIncludeString(self.requiredInclude)).{\(min),\(max)}$"
        }else if regEx.isEmpty {
            return "^\(self.getRequiredIncludeString(self.requiredInclude))([\(self.specialSymbols)]{\(min),\(max)})$"
        }else{
            return     "^\(self.getRequiredIncludeString(self.requiredInclude))([\(self.getRegExString(self.regEx))\(self.specialSymbols)]{\(min),\(max)})$"
        }
    }
    
    
    /// 유효성검증을 실행합니다.
    /// - Parameters:
    ///   - text: 생성한 규칙에 맞는지 확인할 문자열
    ///   - completion: 성공시에는 파라미터로 넣은 텍스트가 리턴되고 실패시에는 관련 에러 값이 리턴됩니다.
    public func isValid(_ text: String, completion: (Result<String, RegExMatchedError>) -> ()) {
        let matchResult = NSPredicate(format:"SELF MATCHES %@", self.getCustomRegEx())
        if self.logOption == .verbose {
            print("### line : \(#line) :: custom regular expression: \(self.getCustomRegEx())")
            print("### line : \(#line) :: matchResult : \(matchResult.evaluate(with: text))")
        }
        
        guard let error = checkTextCount(text, min: self.min, max: self.max, logOption: self.logOption) else {
            return !matchResult.evaluate(with: text) ? completion(.failure( self.figureOutErrors(text, logOption: self.logOption) ?? .notMatched)) : completion(.success(text))
        }
        
        return completion(.failure(error))
    }
    
    
    /// 문자열의 최소, 최대길이를 확인합니다.
    /// - Parameters:
    ///   - text: 길이를 확인할 문자열
    ///   - min: 최소길이 조건
    ///   - max: 최대길이 조건
    ///   - logOption: 로그 옵션
    /// - Returns: 최소 및 최대길이 조건에 맞지 않을 경우 에러 타입을 리턴합니다.
    private func checkTextCount(_ text: String, min: Int , max: Int, logOption: LogOptions) -> RegExMatchedError? {
        if text.count < min {
            if logOption == .verbose {
                print("### line : \(#line) :: ERROR DESCRIPTION: \(RegExMatchedError.invalidMin.desc)")
            }
            return .invalidMin
        }
        if text.count > max {
            if logOption == .verbose {
                print("### line : \(#line) :: ERROR DESCRIPTION: \(RegExMatchedError.invalidMax.desc)")
            }
            return .invalidMax
        }
        return nil
    }
    
    
    /// 유효성검사에 실패한 문자열에 대한 에러를 파악합니다.
    /// - Parameters:
    ///   - text: 유효성 검증을 할 문자열
    ///   - logOption: 로그 옵션
    /// - Returns: 조건에 부합하지 않는 에러타입을 리턴합니다.
    private func figureOutErrors(_ text: String, logOption: LogOptions) -> RegExMatchedError? {
        if requiredInclude.isEmpty {
            return .notMatched
        }else{
            
            let errorArray = self.requiredInclude.filter {  [weak self] type in
                guard let self = self else { return false }
                var templateRegEx = ""
                
                switch type {
                case .english :
                    templateRegEx =  "^(?=.*[\(RegExType.english.desc)])([\(RegExType.english.desc)\(RegExType.number.desc)\(RegExType.korean.desc)\(RegExType.specialSymbols.desc)]{\(min),\(max)})$"
                case .korean :
                    templateRegEx =  "^(?=.*[\(RegExType.korean.desc)])([\(RegExType.english.desc)\(RegExType.number.desc)\(RegExType.korean.desc)\(RegExType.specialSymbols.desc)]{\(min),\(max)})$"
                case .number:
                    templateRegEx =  "^(?=.*[\(RegExType.number.desc)])([\(RegExType.english.desc)\(RegExType.number.desc)\(RegExType.korean.desc)\(RegExType.specialSymbols.desc)]{\(min),\(max)})$"
                case .specialSymbols:
                    templateRegEx =  "^(?=.*[\(RegExType.specialSymbols.desc)])([\(RegExType.english.desc)\(RegExType.number.desc)\(RegExType.korean.desc)\(RegExType.specialSymbols.desc)]{\(min),\(max)})$"
                }
                if logOption == .verbose {
                    print("\n### line : \(#line) :: <<< RegEx >>> : \(templateRegEx))")
                    print("### line : \(#line) :: <<< INPUT TEXT >>> : \(text)")
                    print("### line : \(#line) :: <<< match result >>> : \(NSPredicate(format:"SELF MATCHES %@", templateRegEx).evaluate(with: text))")
                }
                let matchResult = NSPredicate(format:"SELF MATCHES %@", templateRegEx)
                return !matchResult.evaluate(with: text)
            }.map { type in
                switch type {
                case .english :
                    return self.requiredInclude.contains(.english) ? RegExMatchedError.notContainedEnglish : RegExMatchedError.notContainedEnglish
                case .korean :
                    return RegExMatchedError.notContainedKorean
                case .number:
                    return RegExMatchedError.notContainedNumber
                case .specialSymbols:
                    return RegExMatchedError.notContainedSpecialSymbols
                }
            }
            if logOption == .verbose {
                print("### line : \(#line) :: <<< ERROR >>> : \(errorArray)")
            }
            return errorArray.isEmpty ? nil : errorArray.first
        }
    }
    
}
