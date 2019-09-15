//
//  MarginsPanel.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import UIKit

protocol MarginsPanelFactory {
  var margins: MarginsPanel { get }
}

struct MarginsPanel {
  let defaultSpacing: CGFloat
  let workExperienceDetailsTitleBottomOffset: CGFloat
}
