//
//  AddCellCollectionViewCell.swift
//  SurfTestApp
//
//  Created by Aliaksandr Pustahvar on 1.08.23.
//

import UIKit

class AddCellCollectionViewCell: UICollectionViewCell {
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    
    var addButtonHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(addButton)
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .systemGray5
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func addButtonTapped() {
        addButtonHandler?()
    }
}
