import Foundation

public final class ValidationDirector {
    ///   커스텀으로 설정한  인스턴스를 리턴합니다.
    /// - Parameter builder: 사용자가 정의한 빌더객체를 전달합니다.
    /// - Returns: STValidator
    public static func createValidator(builder: RegExBuilder) -> STValidator {
        builder.build()
    }
    
}
