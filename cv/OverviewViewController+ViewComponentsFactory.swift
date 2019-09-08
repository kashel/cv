//
//  OverviewViewController+ViewComponentsFactory.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import UIKit

extension OverviewViewController {
  struct ViewComponentsFactory {
    typealias Factory = FontsPaletteFactory & MarginsPaletteFactory
    private let fonts: FontsPalette
    private let margins: MarginsPalette
    
    init(factory: Factory) {
      self.fonts = factory.fonts
      self.margins = factory.margins
    }
    
    var tableView: UITableView {
      let table = UITableView()
      table.separatorStyle = .none
      return table
    }
    
    func sectionHeaderWithTitle(_ title: String) -> UIView {
      let label = UILabel()
      label.font = fonts.overviewSection
      label.textColor = .gray
      label.text = title
      let wrapper = UIView()
      wrapper.addSubview(label)
      label.pinEdges(to: wrapper, offsets: UIEdgeInsets(top: 0, left: 0, bottom: -margins.defaultSpacing, right: 0))
      return wrapper
    }
    
    var titleView: UIView {
      let label = UILabel()
      label.font = fonts.overviewTitle
      label.textColor = .gray
      label.text = "Curriculum vitae"
      let wrapper = UIView()
      wrapper.addSubview(label)
      label.pinEdges(to: wrapper, offsets: UIEdgeInsets(top: margins.defaultSpacing,
                                                        left: margins.defaultSpacing,
                                                        bottom: -2 * margins.defaultSpacing,
                                                        right: -margins.defaultSpacing))
      return wrapper
    }
  }
}
