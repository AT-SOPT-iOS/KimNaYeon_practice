//
//  WelcomeViewController.swift
//  SOPT36_WEEK1
//
//  Created by 김나연 on 4/8/25.
//

import UIKit

class WelcomeViewController_Closure: UIViewController {
    var id: String?
    var loginDataCompletion: ((String) -> Void)?
    func setLabelText(id: String?){
        if let id = id, !id.isEmpty {
                self.id = id
        } else {
            self.id = "???"
        }
    }
    
    //MARK: - Property
    private lazy var welcomeImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 121.5, y: 87, width: 150, height: 150))
        imageView.image = UIImage(named: "Charactor")
        return imageView
    }()
    
    private lazy var welcomLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 149, y: 295, width: 95, height: 60))
        label.text = "???님 \n반가워요!"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name: "Pretendard-Bold", size: 25)
        return label
    }()
    
    /// 버튼
    private lazy var goToMainButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 29, y: 426, width: 335, height: 57))
        button.backgroundColor = UIColor.primaryOrange
        button.setTitle("메인으로", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 18)
        button.addTarget(self, action: #selector(backToLoginButtonDidTap), for: .touchUpInside)
        
        /// 둥근 모서리
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var backToLoginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 29, y: 498, width: 335, height: 57))
        button.backgroundColor = UIColor.grey200
        button.setTitle("다시 로그인", for: .normal)
        button.setTitleColor(UIColor.grey300, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 18)
        button.addTarget(self, action: #selector(backToLoginButtonDidTap), for: .touchUpInside)
        
        /// 둥근 모서리
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        return button
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        setLayout()
        
        bindID()
    }
    private func setLayout(){
        [welcomeImage, welcomLabel, goToMainButton, backToLoginButton].forEach{
            self.view.addSubview($0)
        }
    }
    
    //MARK: - Function
    private func bindID(){
        if let id{
            self.welcomLabel.text = "\(id)님 \n반가워요!"
        }
    }
    
    @objc
    private func backToLoginButtonDidTap(){
        guard let loginDataCompletion else {return}
        if let id = id {
            loginDataCompletion(id)
        }
        if self.navigationController == nil {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
