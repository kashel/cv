//
//  cvUITests.swift
//  cvUITests
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import XCTest

class cvUITests: XCTestCase {
  private let app = XCUIApplication()
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    continueAfterFailure = false
    
    app.launchArguments.append(CVLaunchArgument.automatedTestsRun.rawValue)
    app.launch()
  }
  
  func testAllPersonalInformationExist() {
    let labelName = app.staticTexts["personalInformatio.firstNameSurname"]
    XCTAssertTrue(labelName.exists, "name label does not exists")
    
    let phoneLabel = app.staticTexts["personalInformation.phone"]
    XCTAssertTrue(phoneLabel.exists, "label phone does not exists")
    
    let emailLabel = app.staticTexts["personalInformation.email"]
    XCTAssertTrue(emailLabel.exists, "label email does not exists")
    
    let nationalityLabel = app.staticTexts["personalInformation.nationality"]
    XCTAssertTrue(nationalityLabel.exists, "label nationality does not exists")
    
    let dateOfBirthLabel = app.staticTexts["personalInformation.dateOfBirth"]
    XCTAssertTrue(dateOfBirthLabel.exists, "label dateOfBirth does not exists")
  }
  
  func testAllWorkExperienceExist() {
    let datesLabel = app.staticTexts["workExperience.dates"]
    XCTAssertTrue(datesLabel.exists, "label dates does not exists")
    
    let positionLabel = app.staticTexts["workExperience.position"]
    XCTAssertTrue(positionLabel.exists, "label position does not exists")
    
    let employerLabel = app.staticTexts["workExperience.employer"]
    XCTAssertTrue(employerLabel.exists, "label employer does not exists")
    
    let addressLabel = app.staticTexts["workExperience.address"]
    XCTAssertTrue(addressLabel.exists, "label address does not exists")
    
    let typeOfBusinessLabel = app.staticTexts["workExperience.typeOfBusiness"]
    XCTAssertTrue(typeOfBusinessLabel.exists, "label typeOfBusiness does not exists")
  }
  
  func testAllEducationExist() {
    let datesLabel = app.staticTexts["education.dates"]
    XCTAssertTrue(datesLabel.exists, "label dates does not exists")
    
    let qualificationLabel = app.staticTexts["education.qualification"]
    XCTAssertTrue(qualificationLabel.exists, "label qualification does not exists")
    
    let studiesLabel = app.staticTexts["education.studies"]
    XCTAssertTrue(studiesLabel.exists, "label studies does not exists")
    
    let institutionLabel = app.staticTexts["education.institution"]
    XCTAssertTrue(institutionLabel.exists, "label institution does not exists")
  }
  
  func testAllSkillsExist() {
    let motherTongueLabel = app.staticTexts["skills.motherTongue"]
    XCTAssertTrue(motherTongueLabel.exists, "label motherTongue does not exists")
    
    let otherLanguagesLabel = app.staticTexts["skills.otherLanguages"]
    XCTAssertTrue(otherLanguagesLabel.exists, "label otherLanguages does not exists")
    
    let othersSkillsLabel = app.staticTexts["skills.othersSkills"]
    XCTAssertTrue(othersSkillsLabel.exists, "label othersSkills does not exists")
  }
  
  func testWorkExperienceDetails() {
    let cell = app.tables.cells.element(boundBy: 1)
    cell.tap()
    
    let titleLabel = app.staticTexts["workExperienceDetails.title"]
    XCTAssertTrue(titleLabel.exists, "title label does not exists")
    
    let dateAndCityLabel = app.staticTexts["workExperienceDetails.dateAndCity"]
    XCTAssertTrue(dateAndCityLabel.exists, "dateAndCity label does not exists")
  }
}
