//
//  OverviewViewModelMapper.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import Foundation

protocol OverviewViewModelMapperFactory {
  var overviewViewModelMapper: OverviewViewModelMapper { get }
}

protocol OverviewViewModelMapper {
  func map(model: CurriculumVitae) -> OverviewViewController.ViewModel
}

class DefaultOverviewViewModelMapper: OverviewViewModelMapper {
  typealias Section = OverviewViewController.ViewModel.Section
  typealias Subsection = OverviewViewController.ViewModel.Subsection
  
  private func mapPersonalInformation(_ personalInformation: PersonalInformation) -> Section {
    let name = "\(personalInformation.firstName) \(personalInformation.lastName)"
    let firstNameSurname = (title: "First Name / Surname", value: name)
    return Section(title: "Personal Information",
                   details: [Subsection(hasDetails: false,
                                        rows: [firstNameSurname,
                                               (title: "Phone", value: personalInformation.phone),
                                               (title: "Email", value: personalInformation.email),
                                               (title: "Nationality", value: personalInformation.nationality),
                                               (title: "Data of Birth", value: personalInformation.dateOfBirth)])])
  }
  
  private func mapWorkExperience(_ workExperience: WorkExperience) -> Subsection {
    let responsibilities = workExperience.responsibilities.map{ "- \($0)" }.joined(separator: "\n")
    return Subsection(hasDetails: true,
                      rows: [(title: "Dates", value: workExperience.dates),
                             (title: "Position", value: workExperience.position),
                             (title: "Responsibilities", value: responsibilities),
                             (title: "Employer", value: workExperience.employer),
                             (title: "Address", value: workExperience.address),
                             (title: "Type of Business", value: workExperience.typeOfBusiness)])
    
  }
  
  private func mapEducation(_ education: Education) -> Subsection {
    return Subsection(hasDetails: false,
                      rows: [(title: "Dates", value: education.dates),
                             (title: "Qualification", value: education.qualification),
                             (title: "Principal studies", value: education.studies),
                             (title: "Institution", value: education.institution)])
  }
  
  private func mapSkills(_ skills: Skills) -> Section {
    let otherLanguages = skills.otherLanguages.joined(separator: ", ")
    let othersSkills = skills.skills.joined(separator: ", ")
    return Section(title: "Skills and Competences",
                   details: [Subsection(hasDetails: false,
                                       rows: [(title: "Language spoken", value: skills.motherTongue),
                                              (title: "Other language(s)", value: otherLanguages),
                                              (title: "Skills", value: othersSkills)])])
  }
  
  private func mapWorkExperiences(_ workExperiences: [WorkExperience]) -> Section {
    return Section(title: "Work Experience", details: workExperiences.map(mapWorkExperience))
  }
  
  private func mapEducations(_ educations: [Education]) -> Section {
    return Section(title: "Education and Training", details: educations.map(mapEducation))
  }
  
  
  func map(model: CurriculumVitae) -> OverviewViewController.ViewModel {
    let sections = OverviewViewController.SectionOrder.allCases.map { (order) -> Section? in
      switch order {
      case .personalInformation:
        return mapPersonalInformation(model.personalInformation)
      case .workExperience:
        return mapWorkExperiences(model.workExperiences)
      case .education:
        return mapEducations(model.edutations)
      case .skills:
        return mapSkills(model.skills)
      case .summary:
        return nil
      }}.compactMap{ $0 }
    
    return OverviewViewController.ViewModel(sections: sections)
  }
}
