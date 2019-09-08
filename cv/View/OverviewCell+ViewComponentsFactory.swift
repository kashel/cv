//
//  OverviewCell+ViewComponentsFactory.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import UIKit

extension OverviewCell {
  struct ViewComponentsFactory {
    typealias Factory = TitleValueRowBuilder.Factory
    private let factory: Factory
    
    init(factory: Factory) {
      self.factory = factory
    }
    
    struct Margins {
      let spaceBetweenRows: CGFloat
      let leftOffset: CGFloat
      let rightOffset: CGFloat
      let topOffset: CGFloat
      let bottomOffset: CGFloat
    }
    
    private let margins: Margins = {
      return Margins(spaceBetweenRows: 5,
                     leftOffset: 0,
                     rightOffset: -32,
                     topOffset: 0,
                     bottomOffset: -32)
    }()
    
    func rowsWithViewModel(_ viewModel: ViewModel) -> [TitleValueCellRow] {
      let titleValueBuilder = TitleValueRowBuilder(factory: factory)
      return viewModel.rows.map{ titleValueBuilder.addTitle(titleText: $0.title).addValue().build() }
    }
    
    var cellOffsets: UIEdgeInsets {
      return UIEdgeInsets(top: margins.topOffset,
                          left: margins.leftOffset,
                          bottom: margins.bottomOffset,
                          right: margins.rightOffset)
    }
    
    func stackViewWithArrangedSubviews(_ views: [UIView]) -> UIStackView {
      let stack = UIStackView(arrangedSubviews: views)
      stack.axis = .vertical
      stack.spacing = margins.spaceBetweenRows
      return stack
    }
  }
}
