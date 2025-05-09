//
//  InfoViewController.swift
//  SOPT36_WEEK4
//
//  Created by 김나연 on 5/3/25.
//

import UIKit
import SnapKit
import Then

final class InfoViewController: UIViewController {

    // MARK: - Properties

    private var keyword: String = ""
    private var nickname: String = ""

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setLayout()
    }

    // MARK: - Actions

    
    @objc private func searchButtonTap() {
        Task {
            do {
                let nicknameList = try await UserService.shared.fetchNicknameList(
                    keyword: self.keyword.isEmpty ? nil : self.keyword
                )

                let nicknameTexts = nicknameList.nicknameList.map { "\($0)" }.joined(separator: "\n")
                self.infoLabel.text = "닉네임 리스트:\n\(nicknameTexts)"

            } catch {
                self.infoLabel.text = "조회 실패: \(error.localizedDescription)"
            }
        }
    }
    
    @objc private func searchMyButtonTap() {
        Task {
            do {
                let myNickname = try await UserService.shared.fetchMyNickname(userId: keyword)

                let nicknameText = myNickname.nickname
                self.infoLabel.text = "내 닉네임:\n\(nicknameText)"

            } catch {
                self.infoLabel.text = "조회 실패: \(error.localizedDescription)"
            }
        }
    }
    
    @objc private func editNicknameButtonTap() {
        Task {
            do {
                let myNickname: () = try await UserService.shared.editNickname(with: EditNicknameRequestDTO(nickname: nickname), userId: keyword)

                let alert = UIAlertController(
                    title: "이메일 변경 성공",
                    message: "이제 니 이름: \(nickname)",
                    preferredStyle: .alert
                )
                
                let okAction = UIAlertAction(title: "확인", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true)
            } catch {
                let alert = UIAlertController(
                    title: "닉네임 변경 실패",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                let okAction = UIAlertAction(title: "확인", style: .default)
                alert.addAction(okAction)
                self.present(alert, animated: true)
                
                print("닉네임 변경 에러:", error)
            }
        }
    }

    @objc private func textFieldDidEditing(_ textField: UITextField) {
        switch textField {
        case editTextField:
            nickname = textField.text ?? ""
        default:
            keyword = textField.text ?? ""
        }
    }

    // MARK: - Layout

    private func setLayout() {
        self.view.addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(40)
            $0.top.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(100)
        }

        [keywordTextField, editTextField, infoLabel, searchButton, searchMyButton, editNicknameButton].forEach {
            self.stackView.addArrangedSubview($0)
        }
    }

    // MARK: - UI Components

    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.spacing = 20
    }

    private lazy var keywordTextField = UITextField().then {
        $0.addTarget(self, action: #selector(textFieldDidEditing(_:)), for: .editingChanged)
        $0.backgroundColor = .lightGray
        $0.placeholder = "검색할 키워드나 자신의 userId를 입력하세요"
        $0.layer.cornerRadius = 8
        $0.setLeftPadding(12)
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private lazy var editTextField = UITextField().then {
        $0.addTarget(self, action: #selector(textFieldDidEditing(_:)), for: .editingChanged)
        $0.backgroundColor = .lightGray
        $0.placeholder = "수정할 닉네임 입력하슈"
        $0.layer.cornerRadius = 8
        $0.setLeftPadding(12)
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private lazy var searchButton = UIButton().then {
        $0.addTarget(self,
                     action: #selector(searchButtonTap),
                     for: .touchUpInside)
        $0.backgroundColor = .systemBlue
        $0.setTitle("검색", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 8
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private lazy var searchMyButton = UIButton().then {
        $0.addTarget(self,
                     action: #selector(searchMyButtonTap),
                     for: .touchUpInside)
        $0.backgroundColor = .systemBlue
        $0.setTitle("내 닉네임 검색", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 8
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private lazy var editNicknameButton = UIButton().then {
        $0.addTarget(self,
                     action: #selector(editNicknameButtonTap),
                     for: .touchUpInside)
        $0.backgroundColor = .systemRed
        $0.setTitle("닉네임 수정", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 8
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    private lazy var infoLabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 16)
    }
}

// MARK: - Padding Extension

private extension UITextField {
    func setLeftPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
