# iOS(Swift) Delegate, 

## 1. Delegate

- #### 한 객체가 해야할 일을 다른 객체에게 위임하는 것


- #### command를 누르고 클릭 [jump to definition] 


- #### Alt를 누르고 해당 Delegate를 클릭하면 문서를 볼 수 있음.

- #### FirstResponder : 포커스의 우선순위가 최우선

- #### 동시성(protocol을 사용하여 delegate를 정의), 재사용성, 위임


- ### TextFieldDelegate

```Swift
idField.delegate = self
passwordField.delegate = self
//StoryBoard에서는 textfield를 ViewController에 드래그해주면된다.
```

## 2. TableView

- #### Section(그룹) - Row(층) - Cell - Accessory(잘 사용하지 않음)

- #### 필요한 것 :

  1. UITableView

  2. UITableViewCell

  3. Model

     ---Method---

  4. numberOfRowInSection (UITableViewDataSource, optional이 아님)

  5. cellForRowAt (UITableViewDataSource, optional이 아님)

  6. didSelectedRowAt (UITableViewController, optional)

- #### 구현 방법

  1. Table View Controller : 전체가 Table View일 경우, 이 자체로 ViewController로 Delegate 등이 모두 적용이 되어있다.(tableView라는 자체 property가 존재)

     > UITableViewController는 ViewController를 상속한다.

  2. Table View : datasource, delegate 끌어서 할당시켜줘야한다.

     - Table View Cell을 Custom할때 [Attribute Inspector]-[Identifier] (reusable identifier)도 할당해야한다.

       > 왜? Cell의 재사용을 하기 위하여


     - Table View Cell의 ImageView의 사이즈를 지정해주어야한다.

- #### table.reloadData()

- #### refreshControl

#### 3. CollectionView

- #### 필요한 것

  1. numberOfItemInSection
  2. cellForItemAt
  3. didSelectedItemAt

- #### FlowLayout

  1. sizeForItemAt
  2. minimumLineSpacingForSectionAt
  3. minimumInteritemSpacingForSectionAt
  4. insetForSectionAt

## TIP

trailing >= 10 으로 하여 자동으로



> 질문
>
> 1. as! vs as?