//
//  ProfileModel.swift
//  SurfTestApp
//
//  Created by Aliaksandr Pustahvar on 1.08.23.
//

import Foundation

struct Profile {
    let name: String
    let about: String
    let location: String
    let skills: [SkillModel]
    let description: String
    
    struct SkillModel: Codable {
        let skill: String
    }
}
