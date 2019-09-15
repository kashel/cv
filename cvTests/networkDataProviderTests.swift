//
//  cvTests.swift
//  cvTests
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import XCTest
@testable import cv

class MockCVNetworkService: NetworkService {
  private let cv: CurriculumVitae
  
  init(cv: CurriculumVitae) {
    self.cv = cv
  }
  func get<T>(url: URL, result: @escaping (Result<T>) -> ()) where T : Decodable {
    guard let model = cv as? T else {
      return
    }
    result(.success(model))
  }
}

class MockNetworkErrorService: NetworkService {
  enum MockError: Error {
    case someError
  }
  
  private let error: Error
  
  init(error: Error) {
    self.error = error
  }
  
  func get<T>(url: URL, result: @escaping (Result<T>) -> ()) where T : Decodable {
    result(.error(error))
  }
}

class testNetworkDataProvider: XCTestCase {
  
  private let mockCV: CurriculumVitae = {
    let personalInformation = PersonalInformation(firstName: "John",
                                                  lastName: "Doe",
                                                  phone: "123456789",
                                                  email: "test@test.com",
                                                  nationality: "english",
                                                  dateOfBirth: "1980")
    
    let work1 = WorkExperience(dates: "May 2018 -  September 2019",
                               position: "iOS Developer",
                               responsibilities: [
                                "doing a",
                                "doing b",
                                "doing c",
                                "doing d"],
                               employer: "Company",
                               address: "Big city",
                               typeOfBusiness: "Startup")
    
    
    let education = Education(dates: "2006-2011",
                              qualification: "Master of Science",
                              studies: "Computer Science",
                              institution: "University")
    
    
    let skills = Skills(motherTongue: "English", otherLanguages: ["English"], skills: ["Swif", "Objective C", "GIT"])
    return CurriculumVitae(personalInformation: personalInformation,
                           workExperiences: [work1],
                           edutations: [education],
                           skills: skills)
  }()
  
  func testSuccessResult() {
    let mockNetworkService = MockCVNetworkService(cv: mockCV)
    let urlPalette = NetworkURLPalette()
    let dataProvider = NetworkDataProvider(networkService: mockNetworkService, urls: urlPalette)
    var response: Result<CurriculumVitae>?
    dataProvider.loadCV { response = $0 }
    XCTAssert({
      if let response = response, case .success(let responseObject) = response {
        return responseObject == mockCV
      }
      return false
    }(), "Data model returned by data provider should match object from network layer in case of success response")
  }
  
  func testErrorResult() {
    let mockErrorService = MockNetworkErrorService(error: MockNetworkErrorService.MockError.someError)
    let urlPalette = NetworkURLPalette()
    let dataProvider = NetworkDataProvider(networkService: mockErrorService, urls: urlPalette)
    var response: Result<CurriculumVitae>?
    dataProvider.loadCV { response = $0 }
    XCTAssert({
      if let response = response, case .error(_) = response {
        return true
      }
      return false
    }(), "Error response should be returned in data provider completition block in case of network error")
  }
}
