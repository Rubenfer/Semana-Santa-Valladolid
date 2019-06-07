//
//  CofradiaCell.swift
//  Semana Santa Valladolid
//
//  Created by Ruben Fernandez on 07/06/2019.
//  Copyright © 2019 Ruben Fernandez. All rights reserved.
//

import UIKit

class CofradiaCell: UITableViewCell {
    
    private let stack = UIStackView()
    let imgView = UIImageView()
    let label = UILabel()
    
    func configureCell() {
        self.label.numberOfLines = 0
        self.label.lineBreakMode = .byWordWrapping
        self.stack.addArrangedSubview(imgView)
        self.stack.addArrangedSubview(label)
        self.stack.axis = .horizontal
        self.stack.spacing = 10
        self.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        imgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate( [
            self.stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.imgView.widthAnchor.constraint(equalToConstant: 80)
            ])
    }
    
}
