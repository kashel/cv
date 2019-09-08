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
