//
//  overviewViewModelMapperTests.swift
//  cvTests
//
//  Created by Ireneusz Solek on 13/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import XCTest
@testable import cv

class overviewViewModelMapperTests: XCTestCase {
  func generateWorkExperienceArray(capacity: UInt ) -> [WorkExperience] {
    return (1 ... capacity).map { _ in
      WorkExperience(dates: "",
                     position: "",
                     responsibilities: [],
                     employer: "",
                     address: "",
                     typeOfBusiness: "")
    }
  }
  
  func generateEducation(capacity: UInt) -> [Education] {
    return (1 ... capacity).map{ _ in
      return Education(dates: "", qualification: "", studies: "", institution: "")
    }
  }
  
  private let skills = Skills(motherTongue: "", otherLanguages: [], skills: [])
  private let personalInformation = PersonalInformation(firstName: "",
                                                        lastName: "",
                                                        phone: "",
                                                        email: "",
                                                        nationality: "",
                                                        dateOfBirth: "")
  
  func testNumberOfSections() {
    let mockCV = CurriculumVitae(personalInformation: personalInformation,
                                 workExperiences: generateWorkExperienceArray(capacity: 1),
                                 edutations: generateEducation(capacity: 1),
                                 skills: skills)
    let viewModelMapper = DefaultOverviewViewModelMapper()
    let viewModel = viewModelMapper.map(model: mockCV)
    XCTAssertEqual(viewModel.sections.count, 4, "View model mapper should produce 4 sections for CurriculumVitae model")
  }
  
  func testNumberOfWorkExperiences() {
    let mockCV = CurriculumVitae(personalInformation: personalInformation,
                                 workExperiences: generateWorkExperienceArray(capacity: 5),
                                 edutations: generateEducation(capacity: 1),
                                 skills: skills)
    let viewModelMapper = DefaultOverviewViewModelMapper()
    let viewModel = viewModelMapper.map(model: mockCV)
    let sectionViewModel = viewModel.sections[OverviewViewController.SectionOrder.workExperience.rawValue]
    XCTAssertEqual(sectionViewModel.details.count, 5)
  }
  
  func testNumberOfEducations() {
    let mockCV = CurriculumVitae(personalInformation: personalInformation,
                                 workExperiences: generateWorkExperienceArray(capacity: 1),
                                 edutations: generateEducation(capacity: 5),
                                 skills: skills)
    let viewModelMapper = DefaultOverviewViewModelMapper()
    let viewModel = viewModelMapper.map(model: mockCV)
    let sectionViewModel = viewModel.sections[OverviewViewController.SectionOrder.education.rawValue]
    XCTAssertEqual(sectionViewModel.details.count, 5)
  }
}
