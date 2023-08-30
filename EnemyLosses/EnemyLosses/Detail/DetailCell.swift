//
//  DetailCell.swift
// 

import UIKit

class DetailCell: UITableViewCell {
    private var titleLabel = UILabel(frame: .zero)
    private var valueLabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension DetailCell {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: valueLabel.centerYAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            valueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            valueLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            valueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            valueLabel.widthAnchor.constraint(equalToConstant: self.bounds.width/2)
        ])
    }
}

extension DetailCell {
    func configure(titleText: String, valueText: String) {
        titleLabel.text = titleText
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 16)
        
        valueLabel.text = valueText
        valueLabel.textColor = .black
        valueLabel.numberOfLines = 0
        valueLabel.font = .systemFont(ofSize: 16)
    }
}
