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
  
  private func mapWorkExperiences(_ workExperiences: [WorkExperience]) -> Section {
    unowned let unownedSelf = self
    return Section(title: "Work Experience",
                   details: workExperiences.map(unownedSelf.mapWorkExperience))
  }
  
  func map(model: CurriculumVitae) -> OverviewViewController.ViewModel {
    return OverviewViewController.ViewModel(sections: [mapPersonalInformation(model.personalInformation),
                                                       mapWorkExperiences(model.workExperiences)])
  }
}
