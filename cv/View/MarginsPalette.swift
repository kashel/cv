//
//  MarginsPalette.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import UIKit

protocol MarginsPaletteFactory {
  var margins: MarginsPalette { get }
}

struct MarginsPalette {
  let defaultSpacing: CGFloat
  let workExperienceDetailsTitleBottomOffset: CGFloat
}
