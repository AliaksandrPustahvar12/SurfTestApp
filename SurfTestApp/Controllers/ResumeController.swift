//
//  ResumeController.swift
//  SurfTestApp
//
//  Created by Aliaksandr Pustahvar on 11.08.23.
//

import Foundation
import UIKit

final class ResumeController {
    
    let service = SkillsService()
    
    var skills: [Profile.SkillModel]
    let profile: Profile
    
    var isEditingMode = false
    
    
    init() {
        skills = service.fetchSkills()
        profile = .init(
            name: "Pustahvar Aliaksandr",
            about: "Ios devoleper with 2 years of experience.",
            location: "Minsk, Belarus",
            skills: skills,
            description: "I am a former pro basketball player who has transitioned into iOS development. I am passionate about learning and problem solving, and I have a strong desire to continually develop and acquire new knowledge. I have around eight months of experience developing mobile apps in Swift, both independently and as part of a team.")
    }
    
    func editButtonTapped(editButton: UIButton, skillsView: UICollectionView) {
        isEditingMode.toggle()
        if isEditingMode {
            DispatchQueue.main.async {
                editButton.setImage(UIImage(named: "accept"), for: .normal)
            }
        } else {
            DispatchQueue.main.async {
                editButton.setImage(UIImage(named: "pencil"), for: .normal)
            }
        }
        skillsView.reloadData()
    }
    
    func deleteButtonTapped(skill: Profile.SkillModel, indexPath: IndexPath, skillsView: UICollectionView) {
        guard let index = skills.firstIndex(where: { $0.skill == skill.skill}) else { return }
        skills.remove(at: index)
        skillsView.deleteItems(at: [indexPath])
        service.saveSkills(skills)
        skills = service.fetchSkills()
        DispatchQueue.main.async {
            skillsView.reloadData()
        }
    }
  
    func showAlertButtonTapped(editButton: UIButton, skillsView: UICollectionView, view: UIViewController) {

        let alert = UIAlertController(title: "Добавление навыка", message: "Введите название навыка, которым вы владеете", preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = "Введите название"
            textField.autocapitalizationType = .sentences
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(cancelAction)
        let addAction = UIAlertAction(title: "Добавить", style: .default) { _ in
            guard let skill = alert.textFields?.first?.text else { return }
            self.skills.append(Profile.SkillModel(skill: skill))
            self.isEditingMode.toggle()
            self.service.saveSkills(self.skills)
            skillsView.reloadData()
            editButton.setImage(UIImage(named: "pencil"), for: .normal)
        }

        alert.addAction(addAction)
        view.present(alert, animated: true)
    }
    
    private func addSkill(name: String) {

        let newSkill = Profile.SkillModel(skill: name)
        skills.append(newSkill)
        service.saveSkills(skills)
    }
}
