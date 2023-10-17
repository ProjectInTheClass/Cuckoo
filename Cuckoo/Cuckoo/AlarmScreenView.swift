//
//  AlarmScreenView.swift
//  Cuckoo
//
//  Created by 장동우 on 2023/10/17.
//

import UIKit

class AlarmScreenView: UIView {
    
    let firstButton: UIButton = {
        let firstButton = UIButton()
        firstButton.setTitle("알 람 1 번", for: .normal)
        firstButton.isUserInteractionEnabled = true
        firstButton.backgroundColor = .systemPink
        firstButton.titleLabel?.textColor = .white
        return firstButton
    }()
    
    let secondButton: UIButton = {
        let secondButton = UIButton()
        secondButton.setTitle("버 튼 2 번", for: .normal)
        secondButton.isUserInteractionEnabled = true
        secondButton.backgroundColor = .systemOrange
        secondButton.setTitleColor(.black, for: .normal)
        return secondButton
    }()
    
    let thirdButton: UIButton = {
        let thirdButton = UIButton()
        thirdButton.setTitle("버 튼 3 번", for: .normal)
        thirdButton.isUserInteractionEnabled = true
        thirdButton.backgroundColor = .systemMint
        thirdButton.setTitleColor(.black, for: .normal)
        return thirdButton
    }()
    
    let fourthButton: UIButton = {
        let fourthButton = UIButton()
        fourthButton.setTitle("버 튼 4 번", for: .normal)
        fourthButton.isUserInteractionEnabled = true
        fourthButton.backgroundColor = .purple
        fourthButton.setTitleColor(.white, for: .normal)
        return fourthButton
    }()
    
    let fifthButton: UIButton = {
        let fifthButton = UIButton()
        fifthButton.setTitle("버 튼 5 번", for: .normal)
        fifthButton.isUserInteractionEnabled = true
        fifthButton.backgroundColor = .gray
        fifthButton.setTitleColor(.black, for: .normal)
        return fifthButton
    }()
    
    func makeSubView() {
        self.addSubview(firstButton)
        self.addSubview(secondButton)
        self.addSubview(thirdButton)
        self.addSubview(fourthButton)
        self.addSubview(fifthButton)
    }
    
    func makeConstraint() {
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        thirdButton.translatesAutoresizingMaskIntoConstraints = false
        fourthButton.translatesAutoresizingMaskIntoConstraints = false
        fifthButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            firstButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            firstButton.widthAnchor.constraint(equalTo: widthAnchor, constant: 0),
            firstButton.heightAnchor.constraint(equalToConstant: 100),
            secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor),
            secondButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            secondButton.widthAnchor.constraint(equalTo: widthAnchor, constant: 0),
            secondButton.heightAnchor.constraint(equalToConstant: 100),
            thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor),
            thirdButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            thirdButton.widthAnchor.constraint(equalTo: widthAnchor, constant: 0),
            thirdButton.heightAnchor.constraint(equalToConstant: 100),
            fourthButton.topAnchor.constraint(equalTo: thirdButton.bottomAnchor),
            fourthButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            fourthButton.widthAnchor.constraint(equalTo: widthAnchor, constant: 0),
            fourthButton.heightAnchor.constraint(equalToConstant: 100),
            fifthButton.topAnchor.constraint(equalTo: fourthButton.bottomAnchor),
            fifthButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            fifthButton.widthAnchor.constraint(equalTo: widthAnchor, constant: 0),
            fifthButton.heightAnchor.constraint(equalToConstant: 100),
            
        ])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeSubView()
        makeConstraint()
        backgroundColor = .gray
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
