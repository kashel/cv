//
//  ProcessInfo+Payload.swift
//  cv
//
//  Created by Ireneusz Solek on 14/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import Foundation

extension ProcessInfo {
  var isUITestRun: Bool {
    return self.arguments.contains(CVLaunchArgument.automatedTestsRun.rawValue)
  }
}
