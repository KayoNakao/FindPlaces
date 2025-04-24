//
//  KeywordButton.swift
//  FindPlaces
//
//  Created by Kayo on 2025-04-24.
//

import UIKit

class KeywordButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        setTitleColor(.primaryOrange, for: .selected)
        setTitleColor(.label, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
    }
    
}
