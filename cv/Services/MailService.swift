//
//  MailService.swift
//  cv
//
//  Created by Ireneusz Solek on 09/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import UIKit
import MessageUI

protocol MailServiceFactory {
  var mailService: MailService { get }
}

protocol MailService {
  func sendEmail(recipientAddress: String, subject: String, message: String, sourceViewController: UIViewController)
}

final class DefaultMailService: NSObject, MailService {
  private weak var sourceViewController: UIViewController?
  func sendEmail(recipientAddress: String, subject: String, message: String, sourceViewController: UIViewController) {
    self.sourceViewController = sourceViewController
    if MFMailComposeViewController.canSendMail() {
      let mailComposeViewController = MFMailComposeViewController()
      mailComposeViewController.setToRecipients([recipientAddress])
      mailComposeViewController.mailComposeDelegate = self
      mailComposeViewController.setSubject(subject)
      mailComposeViewController.setMessageBody(message, isHTML: false)
      sourceViewController.present(mailComposeViewController, animated: true)
    } else {
      sourceViewController.present(unableToSendAlertController, animated: true, completion: nil)
    }
  }
  
  private var unableToSendAlertController: UIAlertController {
    let controller = UIAlertController(title: L10n.Contact.unableToSendEmail, message: nil, preferredStyle: .alert)
    let action = UIAlertAction(title: L10n.General.ok, style: .cancel, handler: nil)
    controller.addAction(action)
    return controller
  }
}

extension DefaultMailService: MFMailComposeViewControllerDelegate {
  func mailComposeController(_ controller: MFMailComposeViewController,
                             didFinishWith result: MFMailComposeResult,
                             error: Error?) {
    sourceViewController?.dismiss(animated: true, completion: nil)
  }
}
