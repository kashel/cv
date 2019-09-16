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
    typealias Factory = FontsPanelFactory & MarginsPanelFactory
    private let fonts: FontsPanel
    private let margins: MarginsPanel
    
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
      wrapper.backgroundColor = .white
      wrapper.addSubview(label)
      label.pinEdges(to: wrapper, offsets: UIEdgeInsets(top: 0, left: 0, bottom: -margins.defaultSpacing, right: 0))
      return wrapper
    }
    
    var titleView: UIView {
      let label = UILabel()
      label.font = fonts.overviewTitle
      label.textColor = .gray
      label.text = L10n.General.curriculumVitae
      let wrapper = UIView()
      wrapper.addSubview(label)
      label.pinEdges(to: wrapper, offsets: UIEdgeInsets(top: margins.defaultSpacing,
                                                        left: margins.defaultSpacing,
                                                        bottom: -2 * margins.defaultSpacing,
                                                        right: -margins.defaultSpacing))
      return wrapper
    }
    
    var contactAlertController: UIAlertController {
      return UIAlertController(title: L10n.Contact.contactMe, message: nil, preferredStyle: .actionSheet)
    }
    
    func errorAlertWithMessage(_ message: String) -> UIAlertController {
      let discardAction = UIAlertAction(title: L10n.General.ok, style: .cancel, handler: nil)
      let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
      alert.addAction(discardAction)
      return alert
    }
    
    var loadingLabel: UILabel {
      let label = UILabel()
      label.textColor = .lightGray
      label.textAlignment = .center
      return label
    }
    
    func loadingStackViewWithViews(_ arrangedViews: [UIView]) -> UIStackView {
      let stack = UIStackView(arrangedSubviews: arrangedViews)
      stack.axis = .vertical
      stack.spacing = 16
      return stack
    }
    
    var loadingOverlay: UIView {
      let view = UIView()
      view.backgroundColor = .white
      let label = loadingLabel
      label.text = L10n.DataLoading.loading
      let activityIndicator = UIActivityIndicatorView(style: .gray)
      let stack = loadingStackViewWithViews([activityIndicator, label])
      view.translatesAutoresizingMaskIntoConstraints = false
      stack.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(stack)
      stack.pinEdges(to: view, offsets: .zero, edges: [.left, .right])
      stack.center(with: view)
      activityIndicator.startAnimating()
      return view
    }
  }
}
