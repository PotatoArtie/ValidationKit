//
//  File.swift
//  
//
//  Created by Dongju on 2023/06/21.
//

import Foundation

extension String {
    
    /// 문자열이 이메일 형식이 맞는지 확인합니다.
    /// - Returns: 매칭여부가 리턴됩니다.
    public func isValidEmail() -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,30}"
        
        
        let matchResult = NSPredicate(format:"SELF MATCHES %@", regEx)
        return matchResult.evaluate(with: self)
    }
}
