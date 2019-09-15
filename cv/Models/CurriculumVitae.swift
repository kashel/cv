//
//  CurriculumVitae.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import Foundation

struct PersonalInformation: Decodable, Equatable {
  let firstName: String
  let lastName: String
  let phone: String
  let email: String
  let nationality: String
  let dateOfBirth: String
}

struct WorkExperience: Decodable, Equatable {
  let dates: String
  let position: String
  let responsibilities: [String]
  let employer: String
  let address: String
  let typeOfBusiness: String
}

struct Education: Decodable, Equatable {
  let dates: String
  let qualification: String
  let studies: String
  let institution: String
}

struct Skills: Decodable, Equatable {
  let motherTongue: String
  let otherLanguages: [String]
  let skills: [String]
}

struct CurriculumVitae: Decodable, Equatable {
  let personalInformation: PersonalInformation
  let workExperiences: [WorkExperience]
  let edutations: [Education]
  let skills: Skills
}
