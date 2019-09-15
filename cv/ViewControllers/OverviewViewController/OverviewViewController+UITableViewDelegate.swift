//
//  OverviewViewController+UITableViewDelegate.swift
//  cv
//
//  Created by Ireneusz Solek on 15/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import UIKit

extension OverviewViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let sectionViewModel = viewModel?.sections[section] else {
      modelAssertionFailure()
      return UIView()
    }
    return viewComponentsFactory.sectionHeaderWithTitle(sectionViewModel.title)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let sectionOrder = SectionOrder(rawValue: indexPath.section) else {
      return
    }
    
    switch sectionOrder {
    case .workExperience:
      didSelectWorkExperienceWithIndexPath(indexPath)
    case .personalInformation:
      didSelectPersonalInformation()
    default:
      return
    }
  }
  
  private func didSelectWorkExperienceWithIndexPath(_ indexPath: IndexPath) {
    guard let workExperiences = model?.workExperiences,
      let workExperience = workExperiences[optional: indexPath.row] else {
        return
    }
    let details = WorkExperienceDetailsViewController(model: workExperience, factory: factory)
    navigationController?.pushViewController(details, animated: true)
  }
  
  private func didSelectPersonalInformation() {
    guard let personalInformation = model?.personalInformation else {
      modelAssertionFailure()
      return
    }
    unowned let unownedSelf = self
    let contactController = viewComponentsFactory.contactAlertController
    
    let phoneAction = UIAlertAction(title: L10n.Contact.makePhoneCall, style: .default) { _ in
      unownedSelf.handlePhoneActionWithPhone(personalInformation.phone)
    }
    let emailAction = UIAlertAction(title: L10n.Contact.sendEmail, style: .default) { _ in
      unownedSelf.handleEmailActionWithEmail(personalInformation.email, sourceController: unownedSelf)
    }
    let cancelAction = UIAlertAction(title: L10n.General.cancel, style: .cancel, handler: nil)
    
    contactController.addAction(phoneAction)
    contactController.addAction(emailAction)
    contactController.addAction(cancelAction)
    present(contactController, animated: true, completion: nil)
  }
  
  private func handlePhoneActionWithPhone(_ phone: String) {
    guard let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) else {
      present(viewComponentsFactory.errorAlertWithMessage(L10n.Contact.unableToMakePhoneCall),
              animated: true,
              completion: nil)
      return
    }
    UIApplication.shared.open(url)
  }
  
  private func handleEmailActionWithEmail(_ email: String, sourceController: UIViewController) {
    mailService.sendEmail(recipientAddress: email,
                          subject: L10n.Contact.jobOffer,
                          message: L10n.Contact.mailContent,
                          sourceViewController: sourceController)
  }
}

