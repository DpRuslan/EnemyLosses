//
//  NavView.swift
//

import UIKit

protocol CustomLabel {
    func setCustomLabel(label: UILabel, title: String, fontSize: CGFloat, textColor: UIColor, numbersOfLines: Int?)
}

extension CustomLabel {
    func setCustomLabel(label: UILabel, title: String, fontSize: CGFloat, textColor: UIColor,numbersOfLines: Int?) {
        label.text = title
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = textColor
        label.numberOfLines = numbersOfLines ?? 0
        label.textAlignment = .left
    }
}

class NavView: UIView, CustomLabel {
    var titleLabel = UILabel(frame: .zero)
    var titleText: String
    
    init(titleText: String) {
        self.titleText = titleText
        
        super.init(frame: .zero)
        
        addSubview(titleLabel)
        setup()
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        setCustomLabel(label: titleLabel, title: titleText, fontSize: 28, textColor: .black, numbersOfLines: 0)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
