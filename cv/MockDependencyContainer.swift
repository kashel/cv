//
//  MockDependencyContainer.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import Foundation

class DependencyContainer {}

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

extension DependencyContainer: FontsPaletteFactory {
  var fonts: FontsPalette {
    return DefaultFontsPalette()
  }
}

extension DependencyContainer: MarginsPaletteFactory {
  var margins: MarginsPalette {
    return MarginsPalette(defaultSpacing: 16, workExperienceDetailsTitleBottomOffset: 32)
  }
}

extension DependencyContainer: MailServiceFactory {
  var mailService: MailService {
    return DefaultMailService()
  }
}

extension DependencyContainer: URLPaletteFactory {
  var urls: URLPalette {
    return NetworkURLPalette()
  }
}
