# iOS(Swift 4.0) Views, TabBar, Navigation, AutoLayout, MARK

(StoryBoard를 이용한 iOS개발)

#### Slider, Switch, ProgressView, StackView...

## 1.Various View

### ㄱ. StackView

- #### StackView 내용물은 Subview가 아닌 ArrangedSubView

  > SubView :
  >
  > ArrangedSubView :


- ####  StackView에 내용물을 넣기 이전에 StackView의 크기를 먼저 결정짓는다.

  > Constraint나 동적 할당 등으로 크기가 고정되어있지 않으면 안의 내용물로 Frame이 결정됨


- ####  StackView를 채우는 방법

  1. Fill : 알아서 크기를 채움. 어떠한 뷰가 커질지 모른다.
  2. Fill Equally : 균등하게 크기를 유지한다.(자주 사용)
  3. Fill Proportionally : 비율에 맞춰 스택뷰를 채움
  4. Equal Spacing : 모든 뷰들이 일정한 간격으로 배열
  5. Equal Centering : 모든 뷰들이 일정한 Center to Center 간격으로 배열

### ㄴ. ScrollView

- #### 아이폰 디바이스들의 비율이 다름으로 ScrollView의 사용이 중요하다(AutoLayout)


- #### 구성요소 

  1. ContentInset : ContentView 내의 Padding
  2. IndicatorInset : 스크롤 바의 Padding
  3. Offset : 밀리는 정도(스크롤의 위치)

## 2. TabBar, Navigation Controller

- #### TabBar 또는 Navigation Controller 추가 : [Editor]-[Embeded in]-[Navigation Controller]

- #### TabBar Controller를 클릭, 새로운 ViewController에 [control]키와 함께 드래그, [Relationship Segue]-[view controllers]

- #### 파일명 [NSObject+(프로젝트명)].swift를 생성,

  ```swift
  import Foundation

  extension NSObject{
      static var reuseIdentifier: String{
          return String(describing: self)
      }
  }
  ```


- #### Navigation 방식

  ```swift
  let storyBoard = UIStoryboard(name: "Main", bundle: nil)

   guard let secondViewController:SecondViewController = storyBoard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {return}
  //SecondViewController의 [identity]-[Storyboard ID] 설정 필수!
  self.navigationController?.pushViewController(secondViewController, animated: true)
  ------------NSObject+(프로젝트명) 파일 생성 시------------
  let storyBoard = UIStoryboard(name: "Main", bundle: nil)
          guard let thirdViewController = storyBoard.instantiateViewController(withIdentifier: ThirdViewController.reuseIdentifier) as? ThirdViewController else {return}
  present(thirdViewController, animated: true, completion: nil)
  ```

- #### First View로 이동하기

  - #### Unwind Segue

  돌아가고 싶은 ViewController :  `@IBAction func unwindViewController(segue:UIStoryboardSegue){}`

  Unwined segue가 발생할 ViewController 

  1. [ViewController]를 [Exit]으로 드래그 

  2. [Storyboard Unwind Segue]에서 [Identifier] 부여

  3. Alert controller를 통한 unwind

     ```swift
     @IBAction func comeBackAction(_sender : UIButton){
     		//declare Alert controller
             let alertController = UIAlertController(title: "알림", message: "첫 화면으로 돌아가시겠습니까?", preferredStyle: .alert)
             //declare Alert Action
             let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
             let okAction = UIAlertAction(title: "확인", style: .default, handler: {(uialertaction) in
             self.performSegue(withIdentifier: "unwindToFirst", sender: nil)
             })
             alertController.addAction(cancelAction)
             alertController.addAction(okAction)
             self.present(alertController, animated: true, completion: nil)
         }
     ```

     `self.performSegue(withIdentifier: "unwindToFirst", sender: nil)`

  - #### presentingViewController

    ```Swift
    @IBAction func moveFirstViewContrllerBtn(sender : UIButton){
            let presentingController = self.presentingViewController as? UITabBarController
            dismiss(animated: false, completion: {
                let navi = presentingController?.childViewControllers[0] as? UINavigationController
                navi?.popViewController(animated: false)
                })
        }	
    ```

## 3. AutoLayout

> Auto Layout **dynamically ** calculates the size and position of all the views in your view hierarchy, based on constraints placed on those views
>
> Automatic-preview로 Constraint 걸린 것을 디바이스별로 확인할 수 있음.

### ㄱ. Constraint

- #### 구성요소

  1. Item 1, 2 : 기준이 될 item1, 적용이 될 item2
  2. Multiplier
  3. Constant


- #### (X, Y)좌표와 Width, Heigth를 결정해줘야한다!!

- #### Top, Left(leading), Right(trailing), Bottom

  > leading : 글씨 시작점(한국은 왼쪽, 아랍어는 오른쪽 등)
  >
  > trailing : leading의 반대

- #### Content Hugging : 컨텐츠가 늘어나지 않게(자주 사용) / 컨텐츠 고유 사이즈보다 **뷰가 커지지 않도록** 제한


- #### Compression Resistance : 컨텐츠가 늘어나게 /. 컨텐츠 고유 사이즈보다 **뷰가 작아지지 않도록** 제한

- #### View가 자기 자신을 끌면 ratio를 유지할 수 있음

  > Width, Height의 경우 16 이하의 값은 괜찮지만, 웬만해서는 고정시키지말고 ratio를 설정하자

- #### ScrollView에서는 Vertical Sapcing을 주도록 한다.

  > ScrollView에서 View끼리 Top을 맞춘다 = y축에 대하여 동일선상에 놓는다.(잘못된 방법)

## 4. Mark

```swift
//MARK:-Properties

//MARK:IBAction
```

## 5. WebKit

- #### [info.plist]-"App Transport Sequrity Settings"-"Allow Arbitrary Loads(True)", "Allow Arbitrary Loads in Web … (True)"

- #### ViewController-Bottom Bar-Translucent Tollbar

## 6. Tap Gesture

- ####  ImageView에 Tap Gesture을 부여할 시, "User Interaction Enabled"를 체크해야함.

## 7. Custom Toggle Button

- Create ToggleButtonCollection and Connect IBAction

  ```Swift
  @IBOutlet var toggleBtnCollection: [UIButton]!

  @IBAction func toggleBtnTouchUp(_ sender:UIButton){
          for button in toggleBtnCollection
          {
              if(button == sender){
                  button.isSelected = true
              }
              else{
                  button.isSelected = false
              }
          }
      }
  ```

  ​

## 8. Tip

- #### 모든 것은 Navigation Controller가 수행한다.

  ##### `view1 -(push)-> view2 -(present)-> view3`

  #### view3를 present시킨 것은 Navigation Controller이다.


- #### Property는 self를 붙여 구분이 가능하게 하자.


- #### swift파일을 만들어서

  ```swift
  NSObject+[ProjectName]

  extension NSObject{

  static var reuseIdentifier: String{

  	return String(describing: self)

  }}
  ```

  #### 코드 상에서는 ControllerName.reuseIdentifier 로 호출하여 사용

- #### ViewController 사이즈 조정하기 : ViewController의 [Attribute Inspector]-[Simulated Size]-"Freeform"으로 변경

