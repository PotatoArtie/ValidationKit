//
//  File.swift
//  
//
//  Created by Dongju on 2023/06/21.
//

import Foundation

protocol Builder: AnyObject {
    var requiredInclude: [RegExType] { get set }
    var regEx: [RegExType] { get set }
    var min: Int { get set }
    var max: Int { get set }
    var specialSymbols: String { get set }
    var logOption: LogOptions { get set }
}
