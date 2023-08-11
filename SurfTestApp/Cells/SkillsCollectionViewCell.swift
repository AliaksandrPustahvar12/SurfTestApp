//
//  SkillsCollectionViewCell.swift
//  SurfTestApp
//
//  Created by Aliaksandr Pustahvar on 1.08.23.
//

import UIKit

class SkillsCollectionViewCell: UICollectionViewCell {
    
    let wordLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        return button
    }()
    
    var deleteButtonHandler: (() -> Void)?
    
    var isEditing: Bool = false {
        didSet {
            deleteButton.isHidden = !isEditing
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(wordLabel)
        contentView.addSubview(deleteButton)
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .systemGray6
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            wordLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            wordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 26),
            wordLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -19),
            deleteButton.leadingAnchor.constraint(equalTo: wordLabel.trailingAnchor, constant: 15),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with skill: Profile.SkillModel) {
        wordLabel.text = skill.skill
    }
    
    @objc private func deleteButtonTapped() {
        deleteButtonHandler?()
    }
    
}
