# iOS(Swift 4.0) 기본 정리(2017.09.26)

## 1. View 전환 및 기본 세팅

#### 0. StoryBoard, ViewController, Info.plist에서 storyboard… 제거

#### 1. AppDelegate

```swift
window = UIWindow(frame: UIScreen.main.bounds)
//bound : 넘어가는 크기까지, frame : 디바이스 화면 자체의 크기

window?.rootViewController = FirstViewController()
//push 방식

window?.rootViewController = UINavigationController(rootViewController: FirstViewController())
//navigation 방식

window?.makeKeyAndVisible()
//이 코드가 없으면 화면이 안나온다.
```

#### 2. 화면 전환

- Present : A의 view 위에 B라는 view를 덮어 올리는것. Dismiss로 B를 지울 수 있음. 부모 view를 접근가능.

> 응용하여 pop up에 사용 가능. (view의 background 색상과 opacity를 적용)

```swift
//Present
self.present(SecondViewController(), animated: true, completion: nil)

//Dismiss
self.dismiss(animated: true, completion: nil)
```

- Push/Pop : 가장 많이 사용. NavigationBar를 통해 사용하면 Back Button이 등장. 이전의 경로들을 가지고 있음. 완전히 A의 view를 없애서 부모 view를 접근불가능

```swift
//Push
self.navigationController?.pushViewController(SecondViewController(), animated: true)

//Pop : pop을 하려는 SecondViewController에 작성
self.navigationController?.popViewController(animated: true)
```

- Segue : StoryBoard에서 사용하는 방식.

## 2. Tip

- Controller 띄우기

```swift
self.present(Controller_Name, animated: true, completion: nil)
```

- String의 Nil or WhiteSpace 

  > C# : String.IsNullOrWhiteSpace

```swift
extension String {
  func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    func NilOrEmpty()->Bool{
        if(self.trim().isEmpty){return true}
        else{return false}
    }
}
```

- Alert Or ActionSheet 띄우기

```swift
//Declare Alert Controller
let alertController = UIAlertController(title: "알림", message: "알림창입니다", preferredStyle: .alert)

//Declare Action
let doneAction = UIAlertAction(title: "확인", style: .default, handler: {(UIAlertAction) in print("확인되었습니다")})
let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
//Add Action
alertController.addAction(doneAction)
alertController.addAction(cancelAction)

//Present Alert Controller
self.present(alertController, animated: true, completion: nil)
```

- Image Load : [Assets.xcassets]에 사용할 resource들을 넣어야한다.

```swift
UIImage(named: “image_name”)
```

##### 