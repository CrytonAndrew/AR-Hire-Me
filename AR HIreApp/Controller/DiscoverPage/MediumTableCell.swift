//
//  MediumTableCell.swift
//  AR HIreApp
//
//  Created by Cryton Sibanda on 2020/08/05.
//  Copyright © 2020 Cryton Sibanda. All rights reserved.
//

import UIKit

class MediumTableCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseIdentifier: String = "MediumTableCell"
    
    let name = UILabel()
    let subtitle = UILabel()
    let imageView = UIImageView()
    let viewButton = UIButton(type: .custom) //Must implement either view profile or show AR model
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        name.font = UIFont.preferredFont(forTextStyle: .headline)
        name.textColor  = .label
        
        subtitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitle.textColor = .secondaryLabel
        
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        
        viewButton.setImage(UIImage(systemName: "greaterthan.circle"), for: .normal)
        
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        viewButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let innnerStackView = UIStackView(arrangedSubviews: [name, subtitle])
        innnerStackView.axis = .vertical
        
        let outterStackView = UIStackView(arrangedSubviews: [imageView, innnerStackView, viewButton])
        outterStackView.translatesAutoresizingMaskIntoConstraints = false
        outterStackView.alignment = .center
        outterStackView.spacing = 10
        contentView.addSubview(outterStackView)
               
        NSLayoutConstraint.activate([
            outterStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outterStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            outterStackView.topAnchor.constraint(equalTo: contentView.topAnchor)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuring(with person: Person) {
        name.text = person.name
        subtitle.text = person.subheading
        imageView.image = UIImage(named: person.image)
    }
    
    
    
    
    
}
