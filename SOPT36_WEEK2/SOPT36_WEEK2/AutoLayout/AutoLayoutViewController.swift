//
//  AutoLayoutViewController.swift
//  SOPT36_WEEK2
//
//  Created by 김나연 on 4/12/25.
//

import UIKit

class AutoLayoutViewController: UIViewController {
    
    let viewWidth = UIScreen.main.bounds.width/2
    let viewHeight = UIScreen.main.bounds.height/4
    
    private lazy var yellowView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.clipsToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        super.viewDidLoad()
        setLayout()
        
    }
    
    private func setLayout(){
        [yellowView, greenView, blackView, blueView].forEach{
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([yellowView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0), yellowView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0), yellowView.widthAnchor.constraint(equalToConstant: viewWidth), yellowView.heightAnchor.constraint(equalToConstant: viewHeight)
                                    ])
        NSLayoutConstraint.activate([greenView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.height/4), greenView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0), greenView.widthAnchor.constraint(equalToConstant: viewWidth), greenView.heightAnchor.constraint(equalToConstant: viewHeight)
                                    ])
        NSLayoutConstraint.activate([blackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.height/2), blackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0), blackView.widthAnchor.constraint(equalToConstant: viewWidth), blackView.heightAnchor.constraint(equalToConstant: viewHeight)
                                    ])
        NSLayoutConstraint.activate([blueView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIScreen.main.bounds.height/4*3), blueView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0), blueView.widthAnchor.constraint(equalToConstant: viewWidth), blueView.heightAnchor.constraint(equalToConstant: viewHeight)
                                    ])
    }
}
