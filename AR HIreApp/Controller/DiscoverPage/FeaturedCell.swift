//
//  FeaturedCell.swift
//  AR HIreApp
//
//  Created by Cryton Sibanda on 2020/08/05.
//  Copyright © 2020 Cryton Sibanda. All rights reserved.
//

import UIKit

class FeaturedCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseIdentifier: String = "FeaturedCell"
    
    let tagLine = UILabel()
    let name = UILabel()
    let subtitle = UILabel()
    let imageView = UIImageView()
    
    
    
    func configuring(with person: Person) {
        tagLine.text = person.tagline.uppercased()
        name.text = person.name
        subtitle.text = person.subheading
        imageView.image = UIImage(named: person.image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let separator  = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        
        tagLine.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold))
        tagLine.textColor = .systemGray
        
        name.font = UIFont.preferredFont(forTextStyle: .title2)
        name.textColor = .label
        
        subtitle.font = UIFont.preferredFont(forTextStyle: .title2)
        subtitle.textColor = .label
        
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        let stackView = UIStackView(arrangedSubviews: [separator, tagLine,  name, subtitle, imageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
                   separator.heightAnchor.constraint(equalToConstant: 1),
                   stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                   stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                   stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
                   stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)])
               
               stackView.setCustomSpacing(10, after: separator)
               stackView.setCustomSpacing(10, after: subtitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
