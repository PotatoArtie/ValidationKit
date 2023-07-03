//
//  ExtensionTests.swift
//  
//
//  Created by Dongju on 2023/07/03.
//

import XCTest

final class ExtensionTests: XCTestCase {

    func test_이메일_유효성검사_성공(){
        // given
        let userEmail = "atlas1234@gmail.com"
        // when
        let isValidExpression = userEmail.isValidEmail()
        print(isValidExpression)
        // then
        XCTAssertTrue(isValidExpression)
    }
    
    func test_이메일_유효성검사_실패(){
        // given
        let userEmail = "atlas1234gmail.com"
        // when
        let isValidExpression = userEmail.isValidEmail()
        
        // then
        XCTAssertFalse(isValidExpression)
    }
}
