//
//  ResumeController.swift
//  SurfTestApp
//
//  Created by Aliaksandr Pustahvar on 11.08.23.
//

import Foundation
//import UIKit

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
    
    func editButtonTapped() {
        isEditingMode.toggle()
    }
    
    func deleteButtonTapped(skill: Profile.SkillModel, indexPath: IndexPath) {
        guard let index = skills.firstIndex(where: { $0.skill == skill.skill}) else { return }
        skills.remove(at: index)
        service.saveSkills(skills)
        skills = service.fetchSkills()
    }
    
    func addSkill(skill: String) {
        self.skills.append(Profile.SkillModel(skill: skill))
        self.isEditingMode.toggle()
        self.service.saveSkills(self.skills)
    }
    
    func getCellSize(indexPath: IndexPath, attributes: [NSAttributedString.Key: Any] ) -> CGSize {
        
        if indexPath.row == skills.count {
            return CGSize(width: 48, height: 48)
        } else {
            let skill = skills[indexPath.item].skill
            var size: CGSize = CGSize(width: 50, height: 40)
            if !isEditingMode {
                size = skill.size(withAttributes: attributes)
            } else {
                size = skill.size(withAttributes: attributes)
                size.width += 30
            }
            return CGSize(width: size.width + 50,  height: size.height + 30)
        }
    }
}
