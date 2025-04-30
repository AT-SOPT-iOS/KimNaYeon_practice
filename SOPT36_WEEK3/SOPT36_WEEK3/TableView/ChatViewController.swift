//
//  ChatViewController.swift
//  SOPT36_WEEK3
//
//  Created by 김나연 on 4/26/25.
//

import UIKit
import SnapKit
import Then

class ChatViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let chatList = ChatModel.dummy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setStyle()
    }
    
    // MARK: - Function
    private func setLayout() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints{ $0.edges.equalToSuperview() }
    }
    private func setStyle() {
        tableView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.identifier)
        }
    }
}
extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as? ChatTableViewCell else { return UITableViewCell() }
                cell.dataBind(chatList[indexPath.row])
        return cell
    }
}
