//
//  LoginViewController_DelegatePattern.swift
//  SOPT36_WEEK2
//
//  Created by 김나연 on 4/12/25.
//

import UIKit

class LoginViewController_DelegatePattern: UIViewController, DataBindDelegate {
    func dataBind(id: String) {
        idTextField.text = id
    }
    
    
    //MARK: - Property
    /// 제목
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 78.5, y: 163, width: 236, height: 44))
        label.text = "동네라서 가능한 모든것\n당근에서 가까운 이웃과 함께해요."
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name: "Pretendard-Bold", size: 16)
        return label
    }()
    
    /// 아이디, 비밀번호 입력
    private lazy var idTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 29, y: 276, width: 335, height: 52))
        textField.placeholder = "아이디"
        textField.textColor = UIColor.grey300
        textField.font = UIFont(name: "Pretendard-Regular", size: 14)
        textField.backgroundColor = UIColor.grey200
        
        /// 패딩 설정
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 23, height: 52))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        /// 둥근 모서리
        textField.layer.cornerRadius = 3
        textField.clipsToBounds = true
        return textField
    }()
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 29, y: 335, width: 335, height: 52))
        textField.placeholder = "비밀번호"
        textField.textColor = UIColor.grey300
        textField.font = UIFont(name: "Pretendard-Regular", size: 14)
        textField.backgroundColor = UIColor.grey200
        
        /// 패딩 설정
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 23, height: 52))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        /// 둥근 모서리
        textField.layer.cornerRadius = 3
        textField.clipsToBounds = true
        return textField
    }()
    
    /// 로그인 버튼
    private lazy var loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 29, y: 422, width: 335, height: 57))
        button.backgroundColor = UIColor.primaryOrange
        button.setTitle("로그인하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 18)
        button.addTarget(self, action: #selector(loginButtonDidTapped), for: .touchUpInside)
        
        /// 둥근 모서리
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        return button
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 폰트 확인
//        UIFont.familyNames.sorted().forEach { familyName in
//            print("*** \(familyName) ***")
//            UIFont.fontNames(forFamilyName: familyName).forEach { fontName in
//                print("\(fontName)")
//            }
//            print("---------------------")
//        }
        
        self.view.backgroundColor = .white
        setLayout()
    }
    private func setLayout(){
        [titleLabel, idTextField, passwordTextField, loginButton].forEach{
            self.view.addSubview($0)
        }
    }
    
    //MARK: - Function
    private func presentToWelcomeVC(){
        let welcomeViewController = WelcomeViewController_DelegatePattern()
        welcomeViewController.modalPresentationStyle = .formSheet
        welcomeViewController.setLabelText(id: idTextField.text)
        self.present(welcomeViewController, animated: true)
    }
    private func pushToWelcomeVC(){
        let welcomeViewController = WelcomeViewController_DelegatePattern()
        welcomeViewController.delegate = self
        welcomeViewController.id = idTextField.text
        welcomeViewController.setLabelText(id: idTextField.text)
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }
    @objc
    private func loginButtonDidTapped(){
//        presentToWelcomeVC()
        pushToWelcomeVC()
    }
    
    /// 터치시 키보드 내려감
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
