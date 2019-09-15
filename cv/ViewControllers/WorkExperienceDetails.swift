//
//  WorkExperienceDetails.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import UIKit

final class WorkExperienceDetailsViewModelMapper {
  func map(model: WorkExperience) -> WorkExperienceDetailsViewController.ViewModel {
    let title = model.position + " at " + model.employer
    let dateAndCity = model.dates + ", " + model.address
    return WorkExperienceDetailsViewController.ViewModel(title: title,
                                                         dateAndCity: dateAndCity,
                                                         responsibilities: model.responsibilities)
  }
}

final class WorkExperienceDetailsViewController: UIViewController {
  struct ViewModel {
    let title: String
    let dateAndCity: String
    let responsibilities: [String]
  }
  typealias Factory = ViewComponentsFactory.Factory
  private let viewModel: ViewModel
  
  init(model: WorkExperience, factory: Factory) {
    let viewComponents = ViewComponentsFactory(factory: factory)
    let viewModelMapper = WorkExperienceDetailsViewModelMapper()
    self.viewModel = viewModelMapper.map(model: model)
    super.init(nibName: nil, bundle: nil)
    setupView(viewComponentsFactory: viewComponents)
  }
  
  private func setupView(viewComponentsFactory: ViewComponentsFactory) {
    view.backgroundColor = .white
    
    let titleLabel = viewComponentsFactory.titleLabel
    titleLabel.text = viewModel.title
    let dateAndCityLabel = viewComponentsFactory.dateAndCityLabel
    dateAndCityLabel.text = viewModel.dateAndCity
    let responsibilitiesLabels: [UILabel] = viewModel.responsibilities.map {
      let label = viewComponentsFactory.responsibilityLabel
      label.text = $0
      return label
    }
    let resposibilitiesStack = viewComponentsFactory.responsibilitiesStackWithArrangedViews(responsibilitiesLabels)
    let mainStack = viewComponentsFactory.mainStack(title: titleLabel,
                                                    city: dateAndCityLabel,
                                                    responsibilities: resposibilitiesStack)
    
    view.addSubview(mainStack)
    viewComponentsFactory.setupContentView(mainStack, inside: view)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: false)
    navigationController?.navigationBar.tintColor = .gray
  }
}

extension WorkExperienceDetailsViewController {
  struct ViewComponentsFactory {
    typealias Factory = FontsPanelFactory & MarginsPanelFactory
    private let fonts: FontsPanel
    private let margins: MarginsPanel
    
    init(factory: Factory) {
      self.fonts = factory.fonts
      self.margins = factory.margins
    }
    
    var titleLabel: UILabel {
      let label = UILabel()
      label.accessibilityIdentifier = "workExperienceDetails.title"
      label.font = fonts.overviewTitle
      label.textColor = .gray
      return label
    }
    
    var dateAndCityLabel: UILabel {
      let label = UILabel()
      label.accessibilityIdentifier = "workExperienceDetails.dateAndCity"
      label.font = fonts.overviewSection
      label.textColor = .lightGray
      return label
    }
    
    var responsibilityLabel: UILabel {
      let label = UILabel()
      label.numberOfLines = 0
      label.font = fonts.cellValue
      label.textColor = .gray
      return label
    }
    
    func responsibilitiesStackWithArrangedViews(_ arrangesSubviews: [UIView]) -> UIStackView {
      let stack = UIStackView(arrangedSubviews: arrangesSubviews)
      stack.spacing = margins.defaultSpacing
      stack.axis = .vertical
      return stack
    }
    
    func mainStack(title: UIView, city: UIView, responsibilities: UIView) -> UIStackView {
      let stack = UIStackView(arrangedSubviews: [title, city, responsibilities])
      stack.axis = .vertical
      stack.spacing = margins.defaultSpacing
      stack.setCustomSpacing(margins.workExperienceDetailsTitleBottomOffset, after: title)
      return stack
    }
    
    func setupContentView(_ content: UIView, inside outerView: UIView) {
      content.pinToSafeArea(of: outerView,
                            offsets: UIEdgeInsets(top: margins.defaultSpacing,
                                                  left: margins.defaultSpacing,
                                                  bottom: 0,
                                                  right: -margins.defaultSpacing),
                            edges: [.left, .top, .right])
      content.bottomAnchor.constraint(lessThanOrEqualTo: outerView.bottomAnchor)
    }
  }
}
