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
}
