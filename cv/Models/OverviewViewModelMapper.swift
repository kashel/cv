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
    let firstNameSurname = (title: L10n.PersonalInformation.name, value: name)
    return Section(title: L10n.PersonalInformation.sectionTitle,
                   details: [Subsection(hasDetails: false,
                                        rows: [firstNameSurname,
                                               (title: L10n.PersonalInformation.phone, value: personalInformation.phone),
                                               (title: L10n.PersonalInformation.email, value: personalInformation.email),
                                               (title: L10n.PersonalInformation.nationality, value: personalInformation.nationality),
                                               (title: L10n.PersonalInformation.dateOfBirth, value: personalInformation.dateOfBirth)])])
  }
  
  private func mapWorkExperience(_ workExperience: WorkExperience) -> Subsection {
    return Subsection(hasDetails: true,
                      rows: [(title: L10n.WorkExperience.dates, value: workExperience.dates),
                             (title: L10n.WorkExperience.position, value: workExperience.position),
                             (title: L10n.WorkExperience.employer, value: workExperience.employer),
                             (title: L10n.WorkExperience.address, value: workExperience.address),
                             (title: L10n.WorkExperience.typeOfBusiness, value: workExperience.typeOfBusiness)])
    
  }
  
  private func mapEducation(_ education: Education) -> Subsection {
    return Subsection(hasDetails: false,
                      rows: [(title: L10n.Education.dates, value: education.dates),
                             (title: L10n.Education.qualification, value: education.qualification),
                             (title: L10n.Education.studies, value: education.studies),
                             (title: L10n.Education.institution, value: education.institution)])
  }
  
  private func mapSkills(_ skills: Skills) -> Section {
    let otherLanguages = skills.otherLanguages.joined(separator: ", ")
    let othersSkills = skills.skills.joined(separator: ", ")
    return Section(title: L10n.Skills.sectionTitle,
                   details: [Subsection(hasDetails: false,
                                       rows: [(title: L10n.Skills.language, value: skills.motherTongue),
                                              (title: L10n.Skills.otherLanguages, value: otherLanguages),
                                              (title: L10n.Skills.skills, value: othersSkills)])])
  }
  
  private func mapWorkExperiences(_ workExperiences: [WorkExperience]) -> Section {
    return Section(title: L10n.WorkExperience.sectionTitle, details: workExperiences.map(mapWorkExperience))
  }
  
  private func mapEducations(_ educations: [Education]) -> Section {
    return Section(title: L10n.Education.sectionTitle, details: educations.map(mapEducation))
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
