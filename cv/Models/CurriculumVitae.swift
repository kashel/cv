//
//  CurriculumVitae.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import Foundation

struct PersonalInformation: Decodable {
  let firstName: String
  let lastName: String
  let phone: String
  let email: String
  let nationality: String
  let dateOfBirth: String
}

struct WorkExperience: Decodable {
  let dates: String
  let position: String
  let responsibilities: [String]
  let employer: String
  let address: String
  let typeOfBusiness: String
}

struct Education: Decodable {
  let dates: String
  let qualification: String
  let studies: String
  let institution: String
}

struct Skills: Decodable {
  let motherTongue: String
  let otherLanguages: [String]
  let skills: [String]
}

struct CurriculumVitae: Decodable {
  let personalInformation: PersonalInformation
  let workExperiences: [WorkExperience]
  let edutations: [Education]
  let skills: Skills
}
