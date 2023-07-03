//
//  RegExType.swift
//  
//
//  Created by Dongju on 2023/06/21.
//

import Foundation
 
public enum RegExType: String, CaseIterable {
    case number = "0-9"
    case english = "a-zA-Z"
    case korean = "가-힣ㄱ-ㅎㅏ-ㅣ"
    case specialSymbols = "!@#\\$%\\^&\\*\\(\\)\\-\\_\\=\\+\\}\\`\\~\\₩\\[\\{\\]\\?\\;\\:\\,\\<\\.\\>\\'\"/\\|"
    
    var desc: String {
        self.rawValue
    }
}
