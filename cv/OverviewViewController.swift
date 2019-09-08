//
//  ViewController.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {
  typealias Factory = DataProviderFactory & OverviewViewModelMapperFactory
  
  private let tableView: UITableView
  private let dataProvider: DataProvider
  private let overviewViewModelMapper: OverviewViewModelMapper
  private let viewComponentsFactory: ViewComponentsFactory
  private var model: CurriculumVitae? = nil {
    didSet {
      viewModel = model != nil ? overviewViewModelMapper.map(model: model!) : nil
    }
  }
  private var viewModel: ViewModel?
  
  init(factory: Factory) {
    self.dataProvider = factory.dataProvider
    self.overviewViewModelMapper = factory.overviewViewModelMapper
    self.viewComponentsFactory = ViewComponentsFactory()
    self.tableView = viewComponentsFactory.tableView
    super.init(nibName: nil, bundle: nil)
    configure()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension OverviewViewController {
  func configure() {
    unowned let unownedSelf = self
    dataProvider.load(completed: {
      unownedSelf.model = $0
      tableView.reloadData()
    })
    tableView.dataSource = self
    registerCells()
  }
  
  func setupView() {
    view.backgroundColor = .white
    let titleView = viewComponentsFactory.titleView
    view.addSubview(titleView)
    titleView.pinToSafeArea(of: view, edges: [.left, .top, .right])
    
    view.addSubview(tableView)
    tableView.pinToSafeArea(of: view, edges: [.bottom])
    tableView.pinEdges(to: view, offsets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0), edges: [.left, .right])
    tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
  }
  
  func registerCells() {
    unowned let unownedSelf = self
    SectionOrder.allCases.forEach({ unownedSelf.tableView.register(OverviewCell.self,
                                                                   forCellReuseIdentifier: $0.reuseIdentifier) })
  }
}

extension OverviewViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel?.sections.count ?? 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let rows = viewModel?.sections[section].details.count ?? 0
    return rows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let section = SectionOrder(rawValue: indexPath.section),
      let cellViewModel = cellViewModelForIndexPath(indexPath) else {
        assertionFailure("Your view model used to feed OverviewViewController does not correspond with Sections configuration")
        return UITableViewCell()
    }
    let cell = dequeCellForSection(section)
    cell.configureWithViewModel(cellViewModel)
    return cell
  }
  
  private func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let sectionViewModel = viewModel?.sections[section] else {
      assertionFailure("Your view model used to feed OverviewViewController does not correspond with Sections configuration")
      return UIView()
    }
    return viewComponentsFactory.sectionHeaderWithTitle(sectionViewModel.title)
  }
  
  private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 44
  }
  
  private func dequeCellForSection(_ section: SectionOrder) -> OverviewCell {
    return tableView.dequeueReusableCell(withIdentifier: section.reuseIdentifier) as? OverviewCell ?? OverviewCell()
  }
  
  private func cellViewModelForIndexPath(_ indexPath: IndexPath) -> OverviewCell.ViewModel? {
    return viewModel?.sections[indexPath.section].details[indexPath.row]
  }
}
