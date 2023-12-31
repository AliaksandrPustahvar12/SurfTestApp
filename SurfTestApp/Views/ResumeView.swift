//
//  ResumeView.swift
//  SurfTestApp
//
//  Created by Aliaksandr Pustahvar on 11.08.23.
//

import UIKit

class ResumeView: UIViewController {
    
    private let topView = UIView()
    private let profileScrollView = UIScrollView()
    private let contentView = UIView()
    private let profileView = UIView()
    private let titleLabel = UILabel()
    private let locationView = UIView()
    private let locationIcon = UIImageView()
    private let locationLabel = UILabel()
    private let imageView = UIImageView()
    private let editButton = UIButton()
    private let nameLabel = UILabel()
    private let aboutLabel = UILabel()
    private let mySkillsLabel = UILabel()
    private let aboutMeLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private let skillsView: UICollectionView = {
        let layout = LeftAligmentCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let controller = ResumeController()
    private var collectionViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setUpView()
        setUpLayouts()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionViewHeightConstraint.constant =  skillsView.collectionViewLayout.collectionViewContentSize.height
    }
    
    private func setUpView() {
        
        topView.backgroundColor = .systemGray6
        profileScrollView.addSubview(topView)
        
        profileScrollView.alwaysBounceVertical = true
        profileScrollView.showsVerticalScrollIndicator = true
        profileScrollView.backgroundColor = .white
        self.view.addSubview(profileScrollView)
        
        
        contentView.backgroundColor = .white
        profileScrollView.addSubview(contentView)
        setUpProfile()
        setUpSkills()
    }
    
    private func setUpProfile() {
        
        profileView.backgroundColor = .systemGray6
        contentView.addSubview(profileView)
        
        titleLabel.text = "Профиль"
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textAlignment = .center
        profileView.addSubview(titleLabel)
        
        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true
        imageView.accessibilityScroll(.down)
        view.addSubview(imageView)
        
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        nameLabel.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        nameLabel.text = controller.profile.name
        nameLabel.adjustsFontSizeToFitWidth = true
        profileView.addSubview(nameLabel)
        
        aboutLabel.textAlignment = .center
        aboutLabel.numberOfLines = 2
        aboutLabel.font = UIFont.systemFont(ofSize: 15)
        aboutLabel.textColor = .darkGray
        aboutLabel.text = controller.profile.about
        profileView.addSubview(aboutLabel)
        
        profileView.addSubview(locationView)
        
        locationIcon.contentMode = .scaleAspectFit
        locationIcon.image = UIImage(named: "location")
        locationView.addSubview(locationIcon)
        
        locationLabel.text = controller.profile.location
        locationLabel.font = UIFont.systemFont(ofSize: 15)
        locationLabel.textColor = .darkGray
        locationView.addSubview(locationLabel)
    }
    
    private func setUpSkills() {
        
        mySkillsLabel.text = "Мои навыки"
        mySkillsLabel.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(mySkillsLabel)
        
        editButton.setImage(UIImage(named: controller.isEditingMode ? "accept" : "pencil"), for: .normal)
        
        editButton.contentMode = .scaleAspectFit
        editButton.tintColor = .black
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        contentView.addSubview(editButton)
        
        skillsView.delegate = self
        skillsView.dataSource = self
        skillsView.register(SkillsCollectionViewCell.self, forCellWithReuseIdentifier: "SkillsCollectionViewCell")
        skillsView.register(AddCellCollectionViewCell.self, forCellWithReuseIdentifier: "AddCellCollectionViewCell")
        skillsView.backgroundColor = .white
        skillsView.isScrollEnabled = false
        contentView.addSubview(skillsView)
        
        aboutMeLabel.text = "О себе"
        aboutMeLabel.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(aboutMeLabel)
        
        descriptionLabel.text = controller.profile.description
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setUpLayouts() {
        
        profileScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.bottomAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: profileScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: profileScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: profileScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: profileScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: profileScrollView.widthAnchor),
        ])
        
        profileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileView.bottomAnchor.constraint(equalTo: locationIcon.bottomAnchor, constant: 10),
            profileView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            profileView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
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
        
        skillsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skillsView.topAnchor.constraint(equalTo: mySkillsLabel.bottomAnchor, constant: 15),
            skillsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            skillsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
        collectionViewHeightConstraint = skillsView.heightAnchor.constraint(equalToConstant: 50)
        collectionViewHeightConstraint.isActive = true
        
        aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            aboutMeLabel.topAnchor.constraint(equalTo: skillsView.bottomAnchor, constant: 10),
            aboutMeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            aboutMeLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
        ])
    }
    
    @objc private func editButtonTapped() {
        self.controller.editButtonTapped()
        skillsView.reloadData()
        editButton.setImage(UIImage(named: controller.isEditingMode ? "accept" : "pencil"), for: .normal)
    }
    
    private func showAlertButtonTapped() {
        
        var alert = UIAlertController()
        
        alert = createAlert(title: "Добавление навыка",
                            message: "Введите название навыка, которым вы владеете",
                            placeholder: "Введите название", action: UIAlertAction(title: "Добавить", style: .default, handler: { _ in
            guard let skill = alert.textFields?.first?.text else { return }
            self.controller.addSkill(skill: skill)
            self.skillsView.reloadData()
            self.editButton.setImage(UIImage(named: "pencil"), for: .normal)
        }))
        self.present(alert, animated: true)
    }
    
    private func createAlert(title: String, message: String?, placeholder: String, action: UIAlertAction) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = placeholder
            textField.autocapitalizationType = .sentences
            
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
            alert.addAction(cancelAction)
            
            alert.addAction(action)
        }
        return alert
    }
}

extension ResumeView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.controller.isEditingMode {
            print(controller.skills.count)
            return controller.skills.count + 1
        } else {
            return controller.skills.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == controller.skills.count && self.controller.isEditingMode {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddCellCollectionViewCell", for: indexPath) as! AddCellCollectionViewCell
            cell.addButtonHandler = { [weak self] in
                guard let view = self else { return }
                view.showAlertButtonTapped()
            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkillsCollectionViewCell", for: indexPath) as! SkillsCollectionViewCell
            cell.configure(with: controller.skills[indexPath.item])
            cell.isEditing = controller.isEditingMode
            cell.deleteButtonHandler = { [weak self] in
                guard let view = self else { return }
                view.controller.deleteButtonTapped(skill: view.controller.skills[indexPath.item], indexPath: indexPath)
                view.skillsView.deleteItems(at: [indexPath])
                view.skillsView.reloadData()
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.skillsView.reloadData()
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16)]
        return controller.getCellSize(indexPath: indexPath, attributes: attributes)
    }
}
