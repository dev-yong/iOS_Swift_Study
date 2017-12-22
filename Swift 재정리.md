- **함수형 프로그래밍** : 대규모 병렬처리에 용이하며, 함수를 일급객체로 다룬다.

- 타입은 될 수 있는 한 명시해라.

  > 스위프트는 컴파일 시 타입을 확인한다.

- **튜플**의 요소마다 이름을 부여해라.

```swift
typealias PersonTuple = (name: String, age: Int, height: Double)
var person: PersonTuple  = ("Test", 25, 123.4)
person.name
person.age
person.height
```

- `defer` : 꼭 실행해야하는 마무리 자업

## Set

- 순서가 없이 유일한 값인 경우
- 타입 추론 시 **Array**로 추론된다

```swift
let testSet: Set<String> = ["T1", "T2", "T3"]
set1.intersection(set2)         //교집합
set1.symmetricDifference(set2)  //여집합
set1.union(set2)                //합집합
set1.subtracting(set2)          //차집합
```

## Enum

- **Raw Value**를 가질 수 있다

```swift
enum School: String {
    case primary
    case middle = "중학교"
    case high = "고등학교"
    case college = "대학교"
}
let pri = (School.primary).rawValue
let mid = School(rawValue: "중학교")
```

- **Associative Value**를 가질 수 있다

```swift
enum NetworkError {
    case invalidParameter(String, String)
    case timeout
}

let error: NetworkError = .invalidParameter("email", "이메일 형식이 올바르지 않습니다.")
```

- `indirect` : 순환 열거형

```swift
enum NetworkError {
    indirect case invalidParameter(NetworkError, String)
    case timeout
}
let error: NetworkError = .invalidParameter(.timeout, "이메일 형식이 올바르지 않습니다.")

indirect enum NetworkError {
    case invalidParameter(NetworkError, String)
    case timeout
}
```

## 연산자

```swift
let nilValue: Int? = nil
let value = nilValue ?? 0
```

## 흐름제어

- **switch**
  - fallthrough 키워드를 사용하여 case 문을 연속 실행가능
  - 비교값이 한정적인 값이 아닌 경우 default 가 필수
  - where절을 이용하여 조건 확장

```swift
let val: Int = 3
let boolVal: Bool = false
switch (val) {
case 1:
    print("\(val)")
    break
case 2..<10 where boolVal:
    print("\(val)")
    //fallthrough
case 10...:
    print("10 이상")
    break
default: break
}
```

- 반복문의 구문이름표

```swift
loopName: for item in 0...5 {
  print(item)
}
```

## 함수

- **비반환 메서드** : 정상적으로 끝나지 않는 함수

```swift
func crashAndBurn() -> Never {
  fatalError("Crash")
}
```

- `@discardableResult` : 반환 값 무시가능 함수

```swift
@discardableResult func say(sth: String) -> String {
  print(sth)
  return sth
}
say("YES")
```

## 옵셔널

- 변수 또는 상수의 값이 `nil`일 수도 있다.
- 옵셔널은 **열거형**이다.

```swift
public enum Optional<Wrapped> : ExpressibleByNilLiteral {
  case none
  case some(Wrapped)
  ...
}
```

```swift
func checkOptional(value: Int?){
  switch value {
    case .none :
        break
    case .some(let value) where value < 0:
        print(value)
  }
}
```

- **추출**

  - 강제추출

  ```swift
  var value: String? = "Name"
  var val: String = value!
  ```

  - 암시적 추출 : : `nil`로 인하여 오류가 발새하지 않을 확신이 있는 경우

  ```swift
  var value: String! = "Name"
  value = nil
  ```

## 옵셔널 체이닝

```swift
people.address?.building? ...

//빠른종료
guard (조건문) else { 
  return, break, continue, throw
}
```

## 구조체

- 값 타입 : 함수 내부에서 새로운 인스턴스를 생성, 해당 인스턴스의 값을 복사하여 사용
- 멤버와이즈 이니셜라이저
- 스위프트의 기본 데이터 타입들은 구조체로 형성되어있다
- 구조체의 사용 권장 조건
  - 간단한 값의 집합에 대한 캡슐화
  - 캡술화한 값을 복사하는 것이 합당
  - 구조체에 저장된 프로퍼티가 값 타입, 복사하는 것이 합당
  - 상속이 필요없을 때

## 클래스

- 참조 타입 : 함수 내부에서 인스턴스를 참조하여 사용
- `final` 키워드를 사용하여 상속이 불가능하게 한다
- `super`, `override`
- `deinit` : 디이니셜라이저 (소멸자)
- `required` : 반드시 자식 클래스에서 재정의 해줘야하는 이니셜라이저의 키워드
- `class func`은 `static func`와 유사하지만, `class func`는 `override`가능
- 초기화 단계
  1. 저장 프로퍼티에 초기값 할당
     1. 이니셜라이저 호출
     2. 메모리 할당
     3. 저장 프로퍼티 초기화
     4. 부모 클래스에게 초기화 양도
     5. 상속 체이닝(4번 반복)
  2. 저장 프로퍼티들을 사용자 정의할 기회를 얻는다
     1. 지정 인스턴스 사용자 정의
     2. 편의 인스턴스 사용자 정의

> `A === B` : A와 B가 참조 타입일 때, 같은 인스턴스를 가리키는 지 비교

## 상속

- 프로퍼티 재정의
  - 상수 저장(`let`), 읽기전용(`set`)은 재정의할 수 없다
  - 프로퍼티 감시자(`didset`, `willset`)을 재정의하여도 **조상클래스의 프로퍼티 감시자도 동작**한다
- 서브스크립트 재정의
  - 부모클래스 서브스크립트의 **매개변수와 반환 타입이 같아**야한다
- `final` 키워드를 사용하여 재정의를 방지한다
- 이니셜라이저 (책 320p 잘 모르겟다.. 계속 봐야지 ㅠ)
  - **지정 이니셜라이저(Designated Initializer)**
    - **자식 클래스의 Designated** 는 **부모 클래스의 Designated** 를 반드시 **호출**해야한다
  - **편의 이니셜라이저(Convenience Initializer)**
    - **다른 이니셜라이저**를 반드시 **호출**해야한다
    - `extension`에 추가 가능하다
  - 부모가 실패한 이니셜라이저라도, 자식은 기본 이니셜라이저가 가능하다

## 프로퍼티

- **프로퍼티 감시자** : 지연 저장 프로퍼티에서는 사용 불가능.
  이니셜라이저 혹은 초기값을 통해서는 호출되지 않는다
  - `willSet` - `newValue`
  - `didSet` - `oldValue`
- **지연 저장 프로퍼티(Lazy Stored Property)** : 호출이 있어야 값을 초기화킨다 `lazy`

```swift
class Position {
    lazy var x: Double = 0.0
    let y: Double
    init(y: Double) {
        self.y = y
    }
}
let pos = Position(y: 10.0)
print(pos.x) //이 때 프로퍼티 x가 생성
```

```swift
class Perons{
    let name: String
    let hobby: String?
    
  //lazy 키워드가 없으면 self.name 접근이 불가능
    lazy var introduce: () -> String = {
        var introduction: String = "My name is \(self.name)"
        return introduction
    }
    
    init(name: String, hobby: String? = nil) {
        self.name = name
        self.hobby = hobby
    }
}
```

- 함수를 사용한 프로퍼티의 기본값 : **클로저**를 사용

```Swift
class SomeClass{
  let someProperty: SomeType = {
    return someValue //someValue의 타입은 SomeType
  }()
}
```

## 메서드

- 클래스의 메서드는 내부 프로퍼티 변경에 제한이 없다
- 구조체의 메서드는 `mutating` 이라는 키워드를 추가해야한다

```swift
class LevelClass {
    var level: Int = 0{
        didSet{
            print("Level : \(level)")
        }
    }
    func levelUp(){
        self.level += 1
    }
}

struct LevelStruct {
    var level: Int = 0{
        didSet{
            print("Level : \(level)")
        }
    }
    mutating func levelUp(){
        self.level += 1
    }
}
```

## Closure

- 클로저는 참조 타입이다
- 자신 내부의 참조들을 사용할 수 있도록 참조 횟수를 증가시켜 메모리에서 해제된느 것을 방지한다
- `@noescaping` : 함수가 끝난 후 전달된 클로저가 필요 없을 때 사용
- `@escaping`은 클로저 파라미터를 함수 외부에서도 사용할 수 있게 해준다
- `@autocloure` : 전달인자를 갖지 않는다. 클로저가 호출되기 전까지 클로저가 동작하지 않는다. 연산의 지연
  `@autoclosure`는 `@noescaping`이 기본값이다
  `@autoclosure @escaping`

```swift
func serveCustomer(customerProvider: @autoclosure () -> String){
  print(customerProvider)
}
serveCustomer(customerProvider: customer.removeFirst())
// autoclosure 키워드가 있어 customer.removeFirst() 클로저의 연산 값 String이 인자로 전달된다
```

- 매개변수에 클로저 전달

```swift
public func sorted(by areInIncreasingOrder: (Element, Element) -> Bool) -> [Element]
func backwords(first: String, second: String) -> Bool {
  return first > second
}
let result: [String] = value.sorted(by: backwords)
```

```swift
let result: [String] = value.sorted(by: { (first: String, second: String) -> Bool in
return first > second
})
```

- 클로저의 축약형

```swift
let result: [String] = value.sorted(){
    (first, second) in
    return first > second
}
let result: [String] = value.sorted(){
    return $0 > $1
}
let result: [String] = value.sorted(){
    $0 > $1
}
```

- 획득목록

```

```



## 프로토콜

- 특정 역할을 하기 위한 청사진
- `mutating` : 인스턴스 메서드에서 값을 변경한다는 키워드
- 클래스 전용 프로토콜 : `protocol ClassOnly: class {}`
- 이니셜라이저를 요구할 수 있다

| Class         | Struct        |
| ------------- | ------------- |
| required init | init          |
| func          | mutating func |

```swift
protocol Resettable {
    mutating func reset()
    init(name: String)
}

class Position: Resettable {
    var x: Double?
    var y: Double?
    var name: String

    required init(name: String) {
        self.name = name
    }

    func reset() {
        self.x = nil
        self.y = nil
    }
}

struct PositionStruct: Resettable {
    var x: Double?
    var y: Double?
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    mutating func reset() {
        self.x = nil
        self.y = nil
    }
}
```

- 상속과 프로토콜을 동시에

```Swift
class School {
  var name: String
  init(name: String) {
    self.name = name
  }
}

class MiddleSchool: School, Named {
  required override init(name: String) {
    super.init(name: name)
  }
}
```

- 선택적 요구 : `@objc optional`

```swift
import Foundation

@objc protocol Moveable {
    func walk()
    @objc optional func fly() // optional 은 @objc에만 사용 가능
}

class Tiger: Moveable {
    func walk() {
        return
    }
}

class Bird: Moveable {
    func walk() {
        return
    }
    @objc func fly() {
        return
    }
}
```

## 제네릭

- `[이름] < PlaceHolder : Type Constraints>` : Type Constraints는 클래스나 프로토콜로만 줄 수 있다.

```swift
prefix func **M<T: BinaryInteger> (value: T) -> T {}
struct Stack<Element> {}
```

- 프로토콜의 연관타입 : `associatedtype`

```swift
protocol Container{
  associatedtype ItemType
  mutating func append(_ item: itemType)
}
```

## 모나드

- **함수객체**의 일종. 맵함수를 지원하는 **컨테이너** 타입. **값이 있을지 없을지 모르는 상태**를 추가한다 (옵셔널)


- **Contents**를 감싸는 **Context**

```Swift
addFunction(number: Optional(10)) //  Error
print(Optional(2).map(addFunction)) //Optional(12)
```

- `flatMap` : 컨테이너 내부의 값을 가져온다

```swift
let optionalArr: [Int?] = [1, 2, nil, 4]
print( optionalArr.map({$0}) ) //Optional(1), Optional(2), nil, Optional(4)]
print( optionalArr.flatMap({$0}) ) //[1, 2, 4]
```

## 서브스크립트

- **타입의 구현부** 혹은 **타입의 익스텐션 구현부**에 위치해야한다

```Swift
subscript(index: Int) -> Int {
  get{ ... }
  set(newValue){ ... }
}
```
## 타입캐스팅

- `is` : 데이터 타입 확인
- 어떠한 타입으로 다루고 접근해야 할 지 판단할 수 있도록 도와주는 행동
- **다운캐스팅**
  - `as?` : 다운캐스팅 실패 시 `nil` 반환
  - `as!` : 다운캐스팅 실패 시 런타임 오류
- **메타타입** : ''어떠한 타입''의 타입
  - `SomeClass.Type` , `SomeProtocol.Protocol`
  - `Instance.self` : 인스턴스 그 자체
  - `SomeType.self` : SomeType

## 익스텐션

- 값 타입 `extension`에 이니셜라이저 추가
  - 모든 저장 프로터피에 기본값이 존재
  - 추가 사용자저으이 이니셜라이저가 없는 경우


- `class`의 `extension`에 이니셜라이저 추가
  - `convenience`만 가능

## 타입 중첩

```swift
class Student {
  enum School {
    case elementary, middle, high
  }
  var school: School 
  init(school: School){
  	self.school = school
  	super.init()
  }
}
```

## 패턴

- 값을 추출 혹은 무시하는 패턴 : 와일드카드, 식별자, 값 바인딩, 튜플 패턴

  - 와일드카드

  ```Swift
  switch value {
    case _ : break //모든 값 허용
  }

  switch optionalString {
    case "ABC"? : print("Optional Value")
    case _? : print("Not ABC")
    case nil: print("Nil")
  }

  switch tuple{
    case ("name", _, _) : break
    case (_, _, _) : break
  }
  ```

- 패턴 매칭을 위한 패턴 : 열거형 케이스, 옵셔널, 표현, 타입캐스팅

  - 옵셔널 패턴

  ```swift
  var optionalValue: Int? = 100
  if case .some(let value) = optionalValue {
    print(value)
  }
  ```

  - 타입캐스팅 패턴

  ```Swift
  switch someValue {
    case is String: print("String")
    case let value as Int: Pirnt("Int")
    default : break
  }
  ```

  - 표현 패턴 : `switch case`문에서만 사용 가능

  ```Swift
  func ~=(pattern: String, value: Int) -> Bool {
      return pattern == "\(value)"
  }

  point = (0,0)
  switch point {
  case ("0", "0"):
      print("원점")
  default:
      print("원점 외")
  }
  ```

  ```swift
  protocol Personalize {
      var name: String {get}
      var age: Int {get}
  }

  struct Person: Personalize {
      var name: String
      var age: Int
  }

  let person: Person = Person(name: "Name", age: 25)

  func ~=<T: Personalize>(pattern: String, value: T) -> Bool {
      //case "Name"
      return pattern == value.name
  }

  func ~=<T: Personalize>(pattern: T, value: T) -> Bool {
      //case Person(name: "Name", age: 25)
      return pattern.name == value.name && pattern.age == value.age
  }

  func ~=<T: Personalize>(pattern: (T)->Bool, value: T) -> Bool {
      //pattern이 함수형식
      return pattern(value)
  }
  func young<T: Personalize>(value: T) -> Bool {
    	//위 패턴과 함게 사용하여 case young : 
      return value.age <50
  }
  ```

## Where 절

- 패턴에 추가 시 **조건을 추가**시킬 수 있다

```swift
switch value {
  case let value where value < 10 : ...
  case let value where is String : ...
}
```

- 타입에 추가 시 **제약을 추가**시킬 수 있다

```Swift
protocol Printable{
}
extension Printable where Self:BinaryInteger, Self: Comparable{
 	print("BinaryInteger와 Comparable을 준수")
}
```

```swift
func doubled<T>(integerValue: T) -> T where T: BinaryInteger {
}
```

## ARC

- **메모리 관리 기법**으로, **클래스의 인스턴스**에만 적용
- **컴파일 시**에 **Reference Counting** 실시 및 인스턴스 메모리 해제 시점 결정


- 강한 참조
  - 참조의 기본은 강한 참조이다
  - 인스턴스가 참조될 때마다 카운팅이 증가하며, nil을 할당해주면 카운팅이 감소한다
  - 순환 문제 (459p 다시 읽기)
- 약한 참조 `weak`
  - 참조하는 인스턴스의 참조 횟수를 증가시키지 않는다
  - 항상 옵셔널이어야한다
- 미소유 참조 `unowned` 
  - 참조하는 인스턴스가 항상 메모리에 존재할 것이라는 전제를 기반
  - 인스턴스의 참조 횟수를 증가시키지 않는다
  - 잘못 접근 시 런타임 오류 발생

```swift
class Person {
    let name: String
    let hobby: String?
    init(name: String, hobby: String? = nil){
        self.name = name
        self.hobby = hobby
    }
    lazy var introduce: () -> String = { [weak self] in
        guard let 'self' = self else {return "Missing Instance"}
        var introduction: String = "My name is \(self.name)"
        return introduction
    }
}
```

## 오류처리

```swift
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

class VendingMachine {
    func vend(name: String) throws {
        throw VendingMachineError.invalidSelection
    }
    func buy(name: String) throws {
        try vend(name: name)
      //try? vend(name: name) : nil 반환
    }
}
```

## 자주 사용하는 함수

```swift
print(abs(-100)) //절대값
for item in repeatElement(0, count: 5) {
    //repeatElement(0, count: 5) : 0 Element를 5번 반복
    print(item)
}
max(1,2,3,4)
min(1,2,3,4)
print(1,2,3,4, separator: ", ", terminator: "") // 1,2,3,4

var value1 = 100
var value2 = 200
swap(&value1, &value2)
print(value1, value2)

let words = ["하나", "둘", "셋"]
let numbers = 1...3
print(Array(zip(words, numbers)))
```

## @objc

- `@objc` 속성이 부여된 프로토콜은 `@objc` 속성이 부여되지 않은 프로토콜을 상속받을 수 없다
- `@objc` 속성이 부여된 프로토콜을 상속받는 프로토콜은  `@objc` 속성이 부여된다