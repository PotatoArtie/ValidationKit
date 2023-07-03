import XCTest
@testable import ValidationKit

final class ValidationKitTests: XCTestCase {
    //MARK: 필수포함 정규식 유효성 테스트

    func test_조건_필수로영어숫자포함_최소길이8글자_최대길이20글자_예상결과_실패_영어가포함되어있지않습니다(){
        // given
        let builder = RegExBuilder()
            .required([.english, .number]) // 필수로 포함되어야하는 옵션
//            .setLength(min: 8, max: 20) // 기본값 min = 8, max = 20최소,최대 글자
            .setLogOption(.verbose) // 디버그 레벨
        
        let regEx = "12345678"
        let validator = ValidationDirector.createValidator(builder: builder)
        // when
        validator.isValid(regEx) { response in
            // then
            switch response {
            case .success(let success):
                XCTAssertTrue(regEx == success)
            case .failure(let failure):
                XCTAssertFalse(regEx == failure.desc, failure.desc)
            }
        }
    }
    
    func test_조건_필수로영어숫자포함_최소길이2글자_최대길이20글자_예상결과_실패_숫자가포함되어있지않습니다(){
        // given
        let builder = RegExBuilder()
            .required([.english, .number]) // 필수로 포함되어야하는 옵션
            .setLength(min: 2, max: 20) // 기본값 min = 8, max = 20최소,최대 글자
            .setLogOption(.verbose) // 디버그 레벨
        
        let regEx = "abcdef"
        let validator = ValidationDirector.createValidator(builder: builder)
        // when
        validator.isValid(regEx) { response in
            // then
            switch response {
            case .success(let success):
                XCTAssertTrue(regEx == success)
            case .failure(let failure):
                XCTAssertFalse(regEx == failure.desc, failure.desc)
            }
        }
    }

    func test_조건_필수로영어숫자포함_최소길이8글자_최대길이20글자_예상결과_성공(){
        // given
        let builder = RegExBuilder()
            .required([.english, .number,.korean]) // 필수로 포함되어야하는 옵션
            .setLength(min: 2, max: 20) // 기본값 min = 8, max = 20최소,최대 글자
            .setLogOption(.verbose) // 디버그 레벨
        
        let regEx = "abcdef1234가나다"
        let validator = ValidationDirector.createValidator(builder: builder)
        // when
        validator.isValid(regEx) { response in
            // then
            switch response {
            case .success(let success):
                XCTAssertTrue(regEx == success)
            case .failure(let failure):
                XCTAssertFalse(regEx == failure.desc, failure.desc)
            }
        }
    }
    
    func test_조건_필수로영어숫자포함_최소길이8글자_최대길이20글자_예상결과_실패_한글이포함되어있지않습니다(){
        // given
        let builder = RegExBuilder()
            .required([.english, .number, .korean]) // 필수로 포함되어야하는 옵션
            .setLength(min: 2, max: 20) // 기본값 min = 8, max = 20최소,최대 글자
            .setLogOption(.verbose) // 디버그 레벨
        
        let regEx = "abcdef1234!"
        let validator = ValidationDirector.createValidator(builder: builder)
        // when
        validator.isValid(regEx) { response in
            // then
            switch response {
            case .success(let success):
                XCTAssertTrue(regEx == success)
            case .failure(let failure):
                XCTAssertFalse(regEx == failure.desc, failure.desc)
            }
        }
    }
    
    func test_조건_필수로영어숫자한글특수문자포함_최소길이2글자_최대길이20글자_예상결과_성공(){
        // given
        let builder = RegExBuilder()
            .required([.english, .number, .korean, .specialSymbols]) // 필수로 포함되어야하는 옵션
//            .setLength(min: 2, max: 20) // 기본값 min = 8, max = 20최소,최대 글자
            .setLogOption(.verbose) // 디버그 레벨
        
        let regEx = "abcdef1234가나다!"
        let validator = ValidationDirector.createValidator(builder: builder)
        // when
        validator.isValid(regEx) { response in
            // then
            switch response {
            case .success(let success):
                XCTAssertTrue(regEx == success)
            case .failure(let failure):
                XCTAssertFalse(regEx == failure.desc, failure.desc)
            }
        }
    }
    
    func test_조건_필수로영어숫자한글특수문자포함_최소길이2글자_최대길이20글자_영어포함_예상결과_실패_특수문자가포함되어있지않습니다(){
        // given
        let builder = RegExBuilder()
            .required([.english, .number, .korean, .specialSymbols]) // 필수로 포함되어야하는 옵션
            .setLength(min: 2, max: 20) // 기본값 min = 8, max = 20최소,최대 글자
            .setRegex([.english]) // 포함되어야 하는 글자
            .setLogOption(.verbose) // 디버그 레벨
        
        let regEx = "abcdef1234가나다"
        let validator = ValidationDirector.createValidator(builder: builder)
        // when
        validator.isValid(regEx) { response in
            // then
            switch response {
            case .success(let success):
                XCTAssertTrue(regEx == success)
            case .failure(let failure):
                XCTAssertFalse(regEx == failure.desc, failure.desc)
            }
        }
    }
    
    //MARK: 최소, 최대길이 테스트
    
    func test_조건_영어숫자포함_최소길이8글자_최대길이20글자_예상결과_실패_최소길이조건에일치하지않습니다(){
        // given
        let builder = RegExBuilder()
//            .required([.english, .number]) // 필수로 포함되어야하는 옵션
            .setLength(min: 8, max: 20) // 기본값 min = 8, max = 20최소,최대 글자
            .setRegex([.english, .number]) // 포함되어야 하는 글자
            .setLogOption(.verbose) // 디버그 레벨
        
        let regEx = "abc123"
        let validator = ValidationDirector.createValidator(builder: builder)
        // when
        validator.isValid(regEx) { response in
            // then
            switch response {
            case .success(let success):
                XCTAssertTrue(regEx == success)
            case .failure(let failure):
                XCTAssertFalse(regEx == failure.desc, failure.desc)
            }
        }
    }

    func test_조건_영어숫자포함_최소길이2글자_최대길이10글자_예상결과_실패_최대길이조건에일치하지않습니다(){
        // given
        let builder = RegExBuilder()
//            .required([.english, .number]) // 필수로 포함되어야하는 옵션
            .setLength(min: 2, max: 10) // 기본값 min = 8, max = 20최소,최대 글자
            .setRegex([.english, .number]) // 포함되어야 하는 글자
            .setLogOption(.verbose) // 디버그 레벨
        
        let regEx = "abcdef123456"
        let validator = ValidationDirector.createValidator(builder: builder)
        // when
        validator.isValid(regEx) { response in
            // then
            switch response {
            case .success(let success):
                XCTAssertTrue(regEx == success)
            case .failure(let failure):
                XCTAssertFalse(regEx == failure.desc, failure.desc)
            }
        }
    }
    
    
    func test_조건_영어숫자포함_예상결과_성공(){
        // given
        let builder = RegExBuilder()
//            .setLength(min: 8, max: 10) // 기본값 min = 8, max = 20최소,최대 글자
            .setRegex([.english, .number]) // 포함되어야 하는 글자
            .setLogOption(.verbose) // 디버그 레벨
        
        let regEx = "abcd1234"
        let validator = ValidationDirector.createValidator(builder: builder)
        // when
        validator.isValid(regEx) { response in
            // then
            switch response {
            case .success(let success):
                XCTAssertTrue(regEx == success)
            case .failure(let failure):
                XCTAssertFalse(regEx == failure.desc, failure.desc)
            }
        }
    }
    
    func test_조건_영어숫자포함_예상결과_실패_조건에일치하지않습니다(){
        // given
        let builder = RegExBuilder()
//            .setLength(min: 8, max: 10) // 기본값 min = 8, max = 20최소,최대 글자
            .setRegex([.english, .number]) // 포함되어야 하는 글자
            .setLogOption(.verbose) // 디버그 레벨
        
        let regEx = "abcdabcd!@#"
        let validator = ValidationDirector.createValidator(builder: builder)
        // when
        validator.isValid(regEx) { response in
            // then
            switch response {
            case .success(let success):
                XCTAssertTrue(regEx == success)
            case .failure(let failure):
                XCTAssertFalse(regEx == failure.desc, failure.desc)
            }
        }
    }

    //MARK: 콤비네이션
    func test_조건_필수로영어포함_최소길이8글자_최대길이20글자_영어_숫자포함_예상결과_성공(){
        // given
        let builder = RegExBuilder()
            .required([.english]) // 필수로 포함되어야하는 옵션
            .setLength(min: 8, max: 20) // 최소,최대 글자
            .setRegex([.english, .number]) // 포함되어야 하는 글자
            .setLogOption(.verbose) // 디버그 레벨
        
        let regEx = "atlas1234"
        let validator = ValidationDirector.createValidator(builder: builder)
        // when
        validator.isValid(regEx) { response in
            // then
            switch response {
            case .success(let success):
                XCTAssertTrue(regEx == success)
            case .failure(let failure):
                XCTAssertTrue(regEx == failure.desc, failure.desc)
            }
        }
    }
    
    func test_조건_필수로영어포함_최소길이8글자_최대길이20글자_영어_숫자포함_예상결과_실패_조건에일치하지않습니다(){
        // given
        let builder = RegExBuilder()
            .required([.english]) // 필수로 포함되어야하는 옵션
            .setLength(min: 8, max: 20) // 최소,최대 글자
            .setRegex([.english, .number]) // 포함되어야 하는 글자
            .setLogOption(.verbose) // 디버그 레벨
        
        let regEx = "atlas1234!"
        let validator = ValidationDirector.createValidator(builder: builder)
        // when
        validator.isValid(regEx) { response in
            // then
            switch response {
            case .success(let success):
                XCTAssertTrue(regEx == success)
            case .failure(let failure):
                XCTAssertFalse(regEx == failure.desc, failure.desc)
            }
        }
    }
    
    func test_조건_커스텀특수문자_예상결과_성공(){
        // given
        let builder = RegExBuilder()
            .setSpecialCharacter(#",<.>\/?;:'"\[{\]}`~₩!@#$%^&*()-_=+\|"#)
            .setRegex([.english, .number]) // 포함되어야 하는 글자
            .setLogOption(.verbose) // 디버그 레벨
        
        let regEx = "atlas1234!"
        let validator = ValidationDirector.createValidator(builder: builder)
        // when
        validator.isValid(regEx) { response in
            // then
            switch response {
            case .success(let success):
                XCTAssertTrue(regEx == success)
            case .failure(let failure):
                XCTAssertFalse(regEx == failure.desc, failure.desc)
            }
        }
    }
    
    func test_조건_커스텀특수문자_예상결과_실패(){
        // given
        let builder = RegExBuilder()
            .setSpecialCharacter(#"!@#"#)
            .setRegex([.english, .number]) // 포함되어야 하는 글자
            .setLogOption(.verbose) // 디버그 레벨
        
        let regEx = "atlas1234!@#$%"
        let validator = ValidationDirector.createValidator(builder: builder)
        // when
        validator.isValid(regEx) { response in
            // then
            switch response {
            case .success(let success):
                XCTAssertTrue(regEx == success)
            case .failure(let failure):
                XCTAssertFalse(regEx == failure.desc, failure.desc)
            }
        }
    }
}
