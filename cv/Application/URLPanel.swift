//
//  URLPanel.swift
//  cv
//
//  Created by Ireneusz Solek on 09/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import Foundation

protocol URLPanelFactory {
  var urls: URLPanel { get }
}

protocol URLPanel {
  var cv: URL { get }
}

struct NetworkURLPanel: URLPanel {
  var cv: URL {
    let urlString = "https://gist.githubusercontent.com/kashel/f15fe1b3a4534511b6841d7dcedc9bd8/raw/203701ae3d5573f47128cfe690f940908dee7e09/ireneusz_solek_2021.json"
    guard let url = URL(string: urlString) else {
      fatalError("Failed to construct url for network resource")
    }
    return url
  }
}
