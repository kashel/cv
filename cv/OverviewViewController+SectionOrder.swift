//
//  OverviewViewController+SectionOrder.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import Foundation

extension OverviewViewController {
  enum SectionOrder: Int, CaseIterable {
    case personalInformation
    case workExperience
    case education
    case skills
    case summary
  }
}

extension OverviewViewController.SectionOrder {
  var reuseIdentifier: String {
    switch self {
    case .personalInformation:
      return "personalInformation"
    case .workExperience:
      return "workExperience"
    case .education:
      return "education"
    case .skills:
      return "skills"
    case .summary:
      return "summary"
    }
  }
}
