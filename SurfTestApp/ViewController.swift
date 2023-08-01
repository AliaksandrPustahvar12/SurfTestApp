//
//  ViewController.swift
//  SurfTestApp
//
//  Created by Aliaksandr Pustahvar on 1.08.23.
//

import UIKit

class ViewController: UIViewController {
    
    let profileScrollView = UIScrollView()
    let contentView = UIView()
    let profileView = UIView()
    var words = ["Hello", "World", "Lorem", "Ipsum", "Swift", "Collection", "View", "Example"]
    
    let skillsView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    let nameLabel = UILabel()
    let aboutLabel = UILabel()
    let mySkillsLabel = UILabel()
    
    private var isEditingMode = false {
        didSet {
            skillsView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        
        profileScrollView.isScrollEnabled = true
        profileScrollView.backgroundColor = .systemGray6
        self.view.addSubview(profileScrollView)
        
        contentView.backgroundColor = .white
        profileScrollView.addSubview(contentView)
        
        
        
        profileScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            profileScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: profileScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: profileScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: profileScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: profileScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: profileScrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1400)
        ])
        
        createProfileView()
        
        mySkillsLabel.text = "Мои навыки"
        mySkillsLabel.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(mySkillsLabel)
        
        let editButton = UIButton()
        editButton.setImage(UIImage(named: "pencil"), for: .normal)
        editButton.contentMode = .scaleAspectFit
        editButton.tintColor = .black
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        contentView.addSubview(editButton)
        
        skillsView.backgroundColor = .systemPink
        contentView.addSubview(skillsView)
        
        mySkillsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mySkillsLabel.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 20),
            mySkillsLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            mySkillsLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 20),
            editButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            editButton.heightAnchor.constraint(equalToConstant: 25),
            editButton.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        setUpCollectionView()
    }
    
    private func createProfileView() {
        //
        //        let profileView = UIView()
        profileView.backgroundColor = .systemGray6
        contentView.addSubview(profileView)
        
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        let titleLabel = UILabel()
        titleLabel.text = "Профиль"
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textAlignment = .center
        profileView.addSubview(titleLabel)
        
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        nameLabel.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        nameLabel.text = "Пустогвар Александр Евгеньевич"
        nameLabel.adjustsFontSizeToFitWidth = true
        profileView.addSubview(nameLabel)
        
        aboutLabel.textAlignment = .center
        aboutLabel.numberOfLines = 2
        aboutLabel.font = UIFont.systemFont(ofSize: 15)
        aboutLabel.textColor = .darkGray
        aboutLabel.text = "Some words about me and my ios experience."
        profileView.addSubview(aboutLabel)
        
        let locationView = UIView()
        profileView.addSubview(locationView)
        
        let locationIcon = UIImageView()
        locationIcon.contentMode = .scaleAspectFit
        locationIcon.image = UIImage(named: "location")
        locationView.addSubview(locationIcon)
        
        let locationLabel = UILabel()
        locationLabel.text = "Minsk"
        locationLabel.font = UIFont.systemFont(ofSize: 15)
        locationLabel.textColor = .darkGray
        locationView.addSubview(locationLabel)
        
        profileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            profileView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            profileView.heightAnchor.constraint(equalToConstant: 340)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 0),
            titleLabel.leftAnchor.constraint(equalTo: profileView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: profileView.rightAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            nameLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            aboutLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            aboutLabel.leftAnchor.constraint(equalTo: profileView.leftAnchor, constant: 15),
            aboutLabel.rightAnchor.constraint(equalTo: profileView.rightAnchor, constant: -15),
            aboutLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        locationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationView.centerXAnchor.constraint(equalTo: profileView.centerXAnchor),
            locationView.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 1),
            locationView.leftAnchor.constraint(equalTo: profileView.leftAnchor, constant: 15),
            locationView.rightAnchor.constraint(equalTo: profileView.rightAnchor, constant: -15),
            locationView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.centerXAnchor.constraint(equalTo: profileView.centerXAnchor),
            locationLabel.topAnchor.constraint(equalTo: locationView.topAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationIcon.bottomAnchor.constraint(equalTo: locationView.bottomAnchor, constant: -2),
            locationIcon.trailingAnchor.constraint(equalTo: locationLabel.leadingAnchor, constant: -3),
            locationIcon.widthAnchor.constraint(equalToConstant: 15),
            locationIcon.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    private func setUpCollectionView() {
        skillsView.delegate = self
        skillsView.dataSource = self
        skillsView.register(SkillsCollectionViewCell.self, forCellWithReuseIdentifier: "SkillsCollectionViewCell")
        skillsView.backgroundColor = .systemMint
        skillsView.isScrollEnabled = false
        view.addSubview(skillsView)
        
        skillsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skillsView.topAnchor.constraint(equalTo: mySkillsLabel.bottomAnchor, constant: 10),
            skillsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            skillsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            skillsView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc private func editButtonTapped() {
        isEditingMode.toggle()
        skillsView.reloadData()
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkillsCollectionViewCell", for: indexPath) as! SkillsCollectionViewCell
        cell.configure(with: words[indexPath.item])
        cell.isEditing = isEditingMode
        cell.deleteButtonHandler = { [weak self] in
            self?.words.remove(at: indexPath.item)
            self?.skillsView.deleteItems(at: [indexPath])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let word = words[indexPath.item]
        var size: CGSize = CGSize(width: 50, height: 40)
        if !isEditingMode {
            size = word.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)])
        } else {
            size = word.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)])
            size.width += 30
        }
        return CGSize(width: size.width + 50,  height: size.height + 30)
    }
}

