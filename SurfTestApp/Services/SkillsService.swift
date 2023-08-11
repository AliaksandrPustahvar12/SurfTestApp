//
//  SkillsService.swift
//  SurfTestApp
//
//  Created by Aliaksandr Pustahvar on 10.08.23.
//

import Foundation

final class SkillsService {

    private let userDefaults = UserDefaults.standard
    private let skillsKey = "Skills"
    private let defaultSkills = [
        Profile.SkillModel(skill: "Swift"),
        Profile.SkillModel(skill: "SwiftUI"),
        Profile.SkillModel(skill: "Alamofire"),
        Profile.SkillModel(skill: "REST APIs"),
        Profile.SkillModel(skill: "Git"),
        Profile.SkillModel(skill: "SOLID"),
        Profile.SkillModel(skill: "URL Session")
    ]

    func fetchSkills() -> [Profile.SkillModel] {
        guard let data = userDefaults.object(forKey: skillsKey) as? Data
        else { return defaultSkills }

        let skills = (try? JSONDecoder().decode([Profile.SkillModel].self, from: data)) ?? []
        return skills.isEmpty ? defaultSkills : skills
    }

    func saveSkills(_ skills: [Profile.SkillModel]) {
        guard let data = try? JSONEncoder().encode(skills)
        else { return }
        userDefaults.set(data, forKey: skillsKey)
    }
}
