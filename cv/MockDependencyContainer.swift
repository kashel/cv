//
//  MockDependencyContainer.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import Foundation

class MockDependencyContainer {
  private let mockCV: CurriculumVitae = {
    let personalInformation = PersonalInformation(firstName: "John",
                                                  lastName: "Doe",
                                                  phone: "123456789",
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
}

extension MockDependencyContainer: DataProviderFactory {
  var dataProvider: DataProvider {
    return MockDataProvider(mockedData: mockCV)
  }
}

extension MockDependencyContainer: OverviewViewModelMapperFactory {
  var overviewViewModelMapper: OverviewViewModelMapper {
    return DefaultOverviewViewModelMapper()
  }
}

extension MockDependencyContainer: FontsPaletteFactory {
  var fonts: FontsPalette {
    return DefaultFontsPalette()
  }
}
