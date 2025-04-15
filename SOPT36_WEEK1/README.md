### CGRect

`CGRect`의 `x`, `y` 좌표는 **왼쪽 위 모서리 기준**

- **x**: 왼쪽에서부터 얼마나 떨어졌는지 (오른쪽으로 갈수록 커짐)
- **y**: 위에서부터 얼마나 떨어졌는지 (아래로 갈수록 커짐, iOS의 기본 좌표계는 origin이 화면 왼쪽 위야)

### private lazy var 쓴 이유?

| 구문 | 설명 | 메모리/초기화 타이밍 |
| --- | --- | --- |
| `let` | 상수. 생성 시점에 **무조건 초기화**해야 함. 이후 변경 불가 | **바로 초기화됨** |
| `var` | 변수. 언제든 값 변경 가능 | 바로 초기화됨 |
| `lazy var` | **처음 사용할 때까지 초기화 미룸** (지연 초기화) | **나중에 초기화됨** |
| `private` | 외부 접근 막기 (캡슐화) | X |

초기화를 필요할 때 하기 위해서: `let`이나 `var`를 쓰면 viewDidLoad 전에 무조건 초기화
⇒ `lazy`를 쓰면 진짜 필요한 순간(예: `.addSubview()`할 때)에 초기화됨 ⇒ 메모리 효율 높아짐

### 모서리 둥글게

```swift
button.layer.cornerRadius = 6
button.clipsToBounds = true
```

→ true로 설정하면 subview가 view의경계를 넘어갈 시 잘림 / false로 설정하면경계를 넘어가도 잘리지 않음

http://songios.tistory.com/43

### textField inset 주는 방법

1. `leftView` & `rightView` 사용하기
    
    ```swift
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 23, height: 52))
    textField.leftView = paddingView
    textField.leftViewMode = .always
    
    ```
    
2. 서브클래싱해서 inset override
    
    ```swift
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    ```
    
    ```swift
    //서브클래싱
    final class PaddedTextField: UITextField {
        // 패딩값 설정
        private let padding = UIEdgeInsets(top: 0, left: 23, bottom: 0, right: 23)
    
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
    
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
    
        override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
    }
    ```
    

https://velog.io/@comdongsam/UITextField%EC%97%90-text-margin-%EB%84%A3%EA%B8%B0

### **#selector**

- Objective-C 스타일의 메서드를 참조할 때 사용하는 문법
    
    ```swift
    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    ```
    
- `#selector` 안에 들어가는 메서드는 @objc 키워드가 붙어 있어야 함
    
    ```swift
    @objc 
    func buttonTapped() {
        print("버튼 탭됨!")
    }
    ```
    

<작동 원리>

- `@objc func someFunction()` → Objective-C의 런타임에서도 이 함수를 인식할 수 있게 됨.
- `#selector(someFunction)` → Objective-C 방식으로 이 함수를 지목(참조)함.
- 결국 iOS 런타임에서 해당 함수가 호출됨.

### 터치 시 키보드 내려가는 함수

| 요소 | 의미 |
| --- | --- |
| `touchesBegan` | 사용자가 화면을 손가락으로 처음 "터치"했을 때 호출되는 UIKit 터치 이벤트 함수 |
| `override` | UIViewController에서 재정의한 거 (기본 행동 → 커스터마이징) |
| `self.view.endEditing(true)` | 현재 view에서 **포커스를 가진 입력창(UIResponder)을 해제**해서 → **키보드 내림** |

```swift
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
}
```

### nil 처리 안됨 → 공백으로 받음

- `UITextField.text`는 기본적으로 Optional. 그러나 아무것도 안 쓰면 `nil` 이 아니라 `""` (빈 문자열)로 인식
- UIKit은 `.text` 속성을 Optional(`String?`)로 선언하긴 했지만 일반적인 상황에선 빈 문자열로 초기화돼 있음

⇒ 빈 문자열도 같이 처리

```swift
func setLabelText(id: String?){
        if let id = id, !id.isEmpty {
            self.id = id
        } else {
            self.id = "???"
        }
    }
```

### 알아두면 좋은 것

폰트 추가하는 방법: https://velog.io/@minji0801/iOSSwift-Custom-Font-%EC%A0%81%EC%9A%A9%ED%95%98%EA%B8%B0-%EC%95%B1-%EB%82%B4-%ED%8F%B0%ED%8A%B8-%EB%B3%80%EA%B2%BD-%EA%B8%B0%EB%8A%A5

키보드 내리거나 올리는 단축키: ⌘(cmd) + K

주석: 

// MARK: -

// TODO: - 

/// 설명(단축키: ⌥(option)+⌘(cmd)+/ )
