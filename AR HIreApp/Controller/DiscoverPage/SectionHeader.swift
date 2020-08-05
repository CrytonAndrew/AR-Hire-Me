//
//  SectionHeaderCollectionReusableView.swift
//  AR HIreApp
//
//  Created by Cryton Sibanda on 2020/08/05.
//  Copyright © 2020 Cryton Sibanda. All rights reserved.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    static let reuseIdentifier = "SectionHeader"
    
    let title = UILabel()
    let subtitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        
        title.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 22, weight: .bold))
        title.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 22, weight: .bold))
        subtitle.textColor = .secondaryLabel
        
        let stactview = UIStackView(arrangedSubviews: [separator, title, subtitle])
        stactview.translatesAutoresizingMaskIntoConstraints = false
        stactview.axis = .vertical
        addSubview(stactview)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            stactview.leadingAnchor.constraint(equalTo: leadingAnchor),
            stactview.trailingAnchor.constraint(equalTo: trailingAnchor),
            stactview.topAnchor.constraint(equalTo: topAnchor),
            stactview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        stactview.setCustomSpacing(10, after: separator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
