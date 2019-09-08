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
    typealias Factory = FontsPaletteFactory
    private let fonts: FontsPalette
    
    init(factory: Factory) {
      self.fonts = factory.fonts
    }
    
    var tableView: UITableView {
      let table = UITableView()
      table.separatorStyle = .none
      table.allowsSelection = false
      return table
    }
    
    func sectionHeaderWithTitle(_ title: String) -> UIView {
      let label = UILabel()
      label.font = fonts.overviewSection
      label.textColor = .gray
      label.text = title
      let wrapper = UIView()
      wrapper.addSubview(label)
      label.pinEdges(to: wrapper, offsets: UIEdgeInsets(top: 0, left: 0, bottom: -16, right: 0))
      return wrapper
    }
    
    var titleView: UIView {
      let label = UILabel()
      label.font = fonts.overviewTitle
      label.textColor = .gray
      label.text = "Curriculum vitae"
      let wrapper = UIView()
      wrapper.addSubview(label)
      label.pinEdges(to: wrapper, offsets: UIEdgeInsets(top: 16, left: 16, bottom: -32, right: -16))
      return wrapper
    }
  }
}
