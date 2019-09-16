//
//  ViewController.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import UIKit

final class OverviewViewController: UIViewController {
  typealias Factory = DataProviderFactory
    & OverviewViewModelMapperFactory
    & OverviewCell.Factory
    & ViewComponentsFactory.Factory
    & MarginsPanelFactory
    & MailServiceFactory
  
  let tableView: UITableView
  private let dataProvider: DataProvider
  private let overviewViewModelMapper: OverviewViewModelMapper
  let viewComponentsFactory: ViewComponentsFactory
  var model: CurriculumVitae? = nil {
    didSet {
      viewModel = model != nil ? overviewViewModelMapper.map(model: model!) : nil
    }
  }
  var viewModel: ViewModel?
  let factory: Factory
  private var margins: MarginsPanel {
    return factory.margins
  }
  let mailService: MailService
  private lazy var loadingOverlay = viewComponentsFactory.loadingOverlay
  
  init(factory: Factory) {
    self.factory = factory
    self.dataProvider = factory.dataProvider
    self.overviewViewModelMapper = factory.overviewViewModelMapper
    self.mailService = factory.mailService
    self.viewComponentsFactory = ViewComponentsFactory(factory: factory)
    self.tableView = viewComponentsFactory.tableView
    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .white
    configure()
    loadData()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: false)
    super.viewWillAppear(animated)
  }
}

extension OverviewViewController {
  func modelAssertionFailure() {
    assertionFailure("Your model used to feed OverviewViewController does not correspond with Sections configuration")
  }
}

private extension OverviewViewController {
  func loadData() {
    presentLoadingOverlay()
    unowned let unownedSelf = self
    dataProvider.loadCV(completed: { result in
      DispatchQueue.main.async {
        if case .success(let cv) = result {
          unownedSelf.setupView()
          unownedSelf.model = cv
        } else {
          unownedSelf.loadingFailed()
        }
        unownedSelf.dismissLoadingOverlay()
      }
    })
  }
  
  func presentLoadingOverlay() {
    view.addSubview(loadingOverlay)
    loadingOverlay.pinEdges(to: view)
  }
  
  func dismissLoadingOverlay() {
    loadingOverlay.removeFromSuperview()
  }
  
  func loadingFailed() {
    let errorAlert = viewComponentsFactory.errorAlertWithMessage(L10n.DataLoading.loadingFailed)
    let retryAction = UIAlertAction(title: L10n.DataLoading.retry, style: .default) { [unowned self] (_) in
      self.loadData()
    }
    errorAlert.addAction(retryAction)
    present(errorAlert, animated: true, completion: nil)
  }
  
  func configure() {
    tableView.dataSource = self
    tableView.delegate = self
    registerCells()
  }
  
  func setupView() {
    let titleView = viewComponentsFactory.titleView
    view.addSubview(titleView)
    titleView.pinToSafeArea(of: view, edges: [.left, .top, .right])
    
    view.addSubview(tableView)
    tableView.pinToSafeArea(of: view,
                            offsets: UIEdgeInsets(top: 0,
                                                  left: margins.defaultSpacing,
                                                  bottom: 0,
                                                  right: 0),
                            edges: [.bottom, .left, .right])
    tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
  }
  
  func registerCells() {
    unowned let unownedSelf = self
    SectionOrder.allCases.forEach({ unownedSelf.tableView.register(OverviewCell.self,
                                                                   forCellReuseIdentifier: $0.reuseIdentifier) })
  }
}
