//
//  DesignComponents.swift
//  Media_final_project
//
//  Created by TTN on 02/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation
import UIKit

class Component: UIImageView {
    
    let label = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        //update constraints for them to converge on bottom left corner
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func configure(text: String) {
        label.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
