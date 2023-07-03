<img width="698" alt="logo" src="https://user-images.githubusercontent.com/98959780/228770091-87679611-0246-40fe-a351-b80bcd0a7339.png">


# ValidationKit


[![SwiftPM](https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat)](https://swift.org/package-manager/)
[![CodeCoverage](https://img.shields.io/static/v1?label=CodeCoverage&message=100&color=green)]()
[![Platform](https://img.shields.io/static/v1?label=platform&message=iOS&color=lightgrey)]()



## Summary

 **ValidationKit은 원하는 형식의 정규식을 간편하게 만들어 유효성검사를 진행 할 수 있는 기능을 제공합니다.**


## Usage 


- Use {String}.toKorean 
표기방법 : 숫자 + 한글표기

    ###### 소수점 앞자리 16자리까지만 화폐단위 표기 
    최대 '조' 단위 까지 표현 
    1,234조 5,678억 9,123만 4,567원

``` swift 
    [요청]
    "123456780".toKorean 
    [출력]
    1억 2,345만 6,780원
```

- Use {String}.isValidEmail() 
설명 : 문자열이 이메일 형식이 맞는지 확인합니다.  
``` swift 
    [요청]
    "abc@abc.com".isValidEmail() 
    [출력]
    true
```

- Use 커스텀 정규식 생성해서 유효성 검사하기 
사용예시 
포함되어야하는 조건은 영어와 숫자 
필수로 포함되어야하는 조건은 영어, 숫자, 특수문자 
커스텀으로 특수문자 지정 

포함되어야하는 조건에 특수문자가 포함되어 있지않지만 필수로 포함되어야하는 조건에 들어가 있는데
포함되어야하는 조건 및 커스텀 특수문자가 지정을 하지않으면 기본 세팅되어진 특수문자 값을 설정  
로그옵션 .verbose 
``` swift 
    let builder = RegExBuilder()
                    .required([.english,.number,.specialSymbols]) // 필수로 포함되어야하 조건
                    .setLength(min: 8, max: 20) // 최소 최대 글자
                    .setSpecialCharacter(#",<.>\/?;:'"\[{\]}`~₩!@#$%^&*()-_=+\|"#) // 특수문자 설정 
                    .setRegex([.english,.number]) // 포함되어야하는 조건 
                    .setLogOption(.verbose) // 로그 옵션 
                    
    let validator = ValidationDirector.createValidator(builder: builder)
    
    validator.isValid("123123123") { response in
        switch response {
        case .success(let success):
            print(success)
        case .failure(let failure):
            print(failure.desc)
        }
    }
    
    result : 영어가 포함되어 있지 않습니다
    
    *사용시 주의사항* 
    특수문자 설정시 #""# 포맷안에 특수문자 넣어서 전송하도록 
    
```



### Quick Help

![quickhelp](https://user-images.githubusercontent.com/98959780/228849192-ba136303-fd4c-4916-b253-c6c1cb115428.gif)

## Requirement

iOS 11.0+/macOS 10.13+/tvOS 11.0+/watchOS 4.0+
[Apple developer](https://developer.apple.com/documentation/swift/array/reduce(_:_:))

iOS - 'v10' is deprecated : **iOS 11.0** is the oldest supported version

<img width="501" alt="ios_m" src="https://user-images.githubusercontent.com/98959780/229390594-554a7537-9a98-4f15-9c1a-bbabcdd22352.png">

macOS - 'v10_12' is deprecated : **macOS 10.13** is the oldest supported version

<img width="496" alt="macos_m" src="https://user-images.githubusercontent.com/98959780/229390791-9ff53b8b-6375-468c-b285-b39dcba98975.png">

tvOS - 'v10' is deprecated : **tvOS 11.0** is the oldest supported version

<img width="496" alt="tvos_m" src="https://user-images.githubusercontent.com/98959780/229390795-a85416ef-0906-46db-b7b3-0efdbcb9ceb0.png">

watchOS - 'v3' is deprecated : **watchOS 4.0** is the oldest supported version

<img width="369" alt="watchos_m" src="https://user-images.githubusercontent.com/98959780/229390798-951e86c6-7793-4c27-bc73-38d017e6f320.png">


## Installation 

File > Swift Packages > Add Package Dependency
Add 
Select "Up to Next Major" with 0.0.1

``` swift 
  .package(url: "https://github.com/PotatoArtie/KoreanCurrencyKit.git", .upToNextMajor(from: "0.0.1"))
```

## Coverage


## License

**ValidationKit** is under the MIT license. See the LICENSE for details.
