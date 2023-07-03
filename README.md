<img width="698" alt="logo" src="https://user-images.githubusercontent.com/98959780/228770091-87679611-0246-40fe-a351-b80bcd0a7339.png">


# ValidationKit


[![SwiftPM](https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat)](https://swift.org/package-manager/)
[![CodeCoverage](https://img.shields.io/static/v1?label=CodeCoverage&message=100&color=green)]()
[![Platform](https://img.shields.io/static/v1?label=platform&message=iOS&color=lightgrey)]()



## Summary

 **ValidationKit은 원하는 형식의 정규식을 간편하게 만들어 유효성검사를 진행 할 수 있는 기능을 제공합니다.**


## Usage 

### Use {String}.isValidEmail() 
설명 : 문자열이 이메일 형식이 맞는지 확인합니다.  
``` swift 
    [요청]
    "abc@abc.com".isValidEmail()

    [출력]
    true
```


### Use 커스텀 정규식 생성해서 유효성 검사하기 

 [옵션 설명]
``` swift
    .required([.english, .number, , .korean, .specialSymbols]) // 필수로 포함되어야하는 설정
     //영어, 숫자, 한글, 특수문자 4가지 옵션을 제공합니다.
```
``` swift
    .setLength(min: Int, max: Int) // 최소 최대 글자
```
``` swift
    .setSpecialCharacter(#",<.>\/?;:'"\[{\]}`~₩!@#$%^&*()-_=+\|"#) // 특수문자 설정
    //#""# 포맷형식으로 특수문자열을 전달합니다. 예시를 꼭 참고해주세요.
```
``` swift
    .setRegex([.english, .number, , .korean, .specialSymbols]) // 포함되어야하는 조건
    //영어, 숫자, 한글, 특수문자 4가지 옵션을 제공합니다.
```
``` swift
    .setLogOption(.verbose) // 로그레벨
```

### 예시 조건 
1.필수로 포함되어야하는 조건은 영어, 숫자, 특수문자
2.입력받을 문자열의 길이의 최소길이는 8, 최대길이는 20 으로 설정
3.커스텀으로 특수문자 지정 
4.포함되어야하는 조건은 영어와 숫자 
5.로그레벨 .verbose (상세한 로그 제공)

**Code 사용법**

``` swift
    // 빌더패턴으로 필요한 설정을 추가해주세요.
    let builder = RegExBuilder()
                    .required([.english,.number,.specialSymbols]) // 필수로 포함되어야하는 설정
                    .setLength(min: 8, max: 20) // 최소 최대 글자
                    .setSpecialCharacter(#",<.>\/?;:'"\[{\]}`~₩!@#$%^&*()-_=+\|"#) // 특수문자 설정 
                    .setRegex([.english,.number]) // 포함되어야하는 설정
                    .setLogOption(.verbose) // 로그레벨

    //ValidationDirector를 통해 validator 인스턴스를 생성해주세요.
    let validator = ValidationDirector.createValidator(builder: builder)


    let YOURTEXT = "123456789"
    // validator 인스턴스의 isValid(String)을 통해서 유효성 검사를 진행하시면 됩니다.
    validator.isValid(YOURTEXT) { response in
        switch response {
        case .success(let success):
            print(success)
        case .failure(let failure):
            print(failure.desc)
        }
    }
    
    예상 결과 : 영어가 포함되어 있지 않습니다

```

### 사용시 주의사항
특수문자 설정시 **#"{String}"#** 포맷안에 특수문자열을 전달해주세요.
포함조건에 특수문자가 포함되어 있지 않더라도 필수로 포함되어야하는 조건을 설정하는 경우 커스텀 특수문자가 지정을 하지않으면 기본값으로 저장된 특수문자 값을 사용합니다. 


### Quick Help 제공 
![quickhelp builder](https://github.com/PotatoArtie/ValidationKit/assets/98959780/8f1f8167-8d11-4241-b4f5-6aa7a3b2cb69)
![ezgif com-video-to-gif (14)](https://github.com/PotatoArtie/ValidationKit/assets/98959780/dd360994-6c7a-4bd3-a1d1-840024873617)


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
  .package(url: "https://github.com/PotatoArtie/ValidationKit.git", .upToNextMajor(from: "0.0.1"))
```

## Coverage
![coverage](https://github.com/PotatoArtie/ValidationKit/assets/98959780/4d136194-e2ca-4248-947e-3cfa1da97f5b)


## License

**ValidationKit** is under the MIT license. See the LICENSE for details.
