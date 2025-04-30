//
//  UICollectionViewController.swift
//  SOPT36_WEEK3
//
//  Created by 김나연 on 4/26/25.
//

import UIKit
import Then
import SnapKit

class ItemViewController: UIViewController, UICollectionViewDelegate {
    
    final let carrotLineSpacing: CGFloat = 10
    final let carrotInterItemSpacing: CGFloat = 21
    final let cellHeight: CGFloat = 198
    final let carrotInset = UIEdgeInsets(top: 48, left: 20, bottom: 10, right: 20)
    
    private let itemData = ItemModel.dummy()

    private func calculateCellHeight() -> CGFloat {
        let count = CGFloat(itemData.count)
        let heightCount = count / 2 + count.truncatingRemainder(dividingBy: 2)
        return heightCount * cellHeight + (heightCount - 1) * carrotLineSpacing + carrotInset.top + carrotInset.bottom
    }
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private func setStyle() {
        collectionView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        }
    }
    private func setLayout() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setStyle()
        setLayout()
    }
}
extension ItemViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let doubleCellWidth = screenWidth - carrotInset.left - carrotInset.right - carrotInterItemSpacing
        return CGSize(width: doubleCellWidth / 2, height: 198)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return carrotLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return carrotInterItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return carrotInset
    }
}
extension ItemViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as?
                ItemCollectionViewCell else { return UICollectionViewCell() }
        cell.dataBind(itemData[indexPath.item], itemRaw: indexPath.item)
        return cell
    }
}
