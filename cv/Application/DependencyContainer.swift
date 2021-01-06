//
//  DependencyContainer.swift
//  cv
//
//  Created by Ireneusz Solek on 15/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import Foundation
import DecodableNetworkLoader

final class DependencyContainer {}

extension DependencyContainer: DataProviderFactory {
  var dataProvider: DataProvider {
    return NetworkDataProvider(networkService: URLSessionNetworkService(),
                               urls: urls)
  }
}

extension DependencyContainer: OverviewViewModelMapperFactory {
  var overviewViewModelMapper: OverviewViewModelMapper {
    return DefaultOverviewViewModelMapper()
  }
}

extension DependencyContainer: FontsPanelFactory {
  var fonts: FontsPanel {
    return DefaultFontsPanel()
  }
}

extension DependencyContainer: MarginsPanelFactory {
  var margins: MarginsPanel {
    return MarginsPanel(defaultSpacing: 16, workExperienceDetailsTitleBottomOffset: 32)
  }
}

extension DependencyContainer: MailServiceFactory {
  var mailService: MailService {
    return DefaultMailService()
  }
}

extension DependencyContainer: URLPanelFactory {
  var urls: URLPanel {
    return NetworkURLPanel()
  }
}
