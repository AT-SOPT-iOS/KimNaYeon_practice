//
//  ScrollViewViewController.swift
//  SOPT36_WEEK2
//
//  Created by 김나연 on 4/12/25.
//

import UIKit

class ScrollViewViewController: UIViewController {
    let viewWidth = UIScreen.main.bounds.width/2

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.clipsToBounds = true
        return view
    }()
    private lazy var orangeView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.clipsToBounds = true
        return view
    }()
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
    private lazy var blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.clipsToBounds = true
        return view
    }()
    private lazy var purpleView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.clipsToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        setLayout()
    }

    private func setLayout() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [redView, orangeView, yellowView, greenView, blueView, purpleView].forEach{
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            
        }
       
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])

        
        let heightConstraint = contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true

        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: contentView.topAnchor),
            redView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            redView.widthAnchor.constraint(equalToConstant: viewWidth),
            redView.heightAnchor.constraint(equalToConstant: 400)
        ])
        NSLayoutConstraint.activate([
            orangeView.topAnchor.constraint(equalTo: contentView.topAnchor),
            orangeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            orangeView.widthAnchor.constraint(equalToConstant: viewWidth),
            orangeView.heightAnchor.constraint(equalToConstant: 400)
        ])
        NSLayoutConstraint.activate([
            yellowView.topAnchor.constraint(equalTo: redView.bottomAnchor),
            yellowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            yellowView.widthAnchor.constraint(equalToConstant: viewWidth),
            yellowView.heightAnchor.constraint(equalToConstant: 400)
        ])
        NSLayoutConstraint.activate([
            greenView.topAnchor.constraint(equalTo: orangeView.bottomAnchor),
            greenView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            greenView.widthAnchor.constraint(equalToConstant: viewWidth),
            greenView.heightAnchor.constraint(equalToConstant: 400)
        ])
        NSLayoutConstraint.activate([
            blueView.topAnchor.constraint(equalTo: yellowView.bottomAnchor),
            blueView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: viewWidth),
            blueView.heightAnchor.constraint(equalToConstant: 400),
            blueView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            purpleView.topAnchor.constraint(equalTo: greenView.bottomAnchor),
            purpleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            purpleView.widthAnchor.constraint(equalToConstant: viewWidth),
            purpleView.heightAnchor.constraint(equalToConstant: 400),
            purpleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

}
