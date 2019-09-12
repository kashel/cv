//
//  Localizable.swift
//  cv
//
//  Created by Ireneusz Solek on 12/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import Foundation

internal enum L10n {
  
  internal enum Contact {
    internal static let contactMe = L10n.tr("Localizable", "contact.contact_me")
    internal static let jobOffer = L10n.tr("Localizable", "contact.job_offer")
    internal static let makePhoneCall = L10n.tr("Localizable", "contact.make_phone_call")
    internal static let sendEmail = L10n.tr("Localizable", "contact.send_email")
    internal static let unableToSendEmail = L10n.tr("Localizable", "contact.uneble_to_send_email")
    internal static let unableToMakePhoneCall = L10n.tr("Localizable", "contact.uneble_to_make_phone_call")
    internal static let mailContent = L10n.tr("Localizable", "contact.mail_content")
  }
  
  internal enum DataLoading {
    internal static let loading = L10n.tr("Localizable", "data_loading.loading")
    internal static let loadingFailed = L10n.tr("Localizable", "data_loading.loading_failed")
    internal static let retry = L10n.tr("Localizable", "data_loading.retry")
  }
  
  internal enum Education {
    internal static let dates = L10n.tr("Localizable", "education.dates")
    internal static let institution = L10n.tr("Localizable", "education.institution")
    internal static let qualification = L10n.tr("Localizable", "education.qualification")
    internal static let sectionTitle = L10n.tr("Localizable", "education.section_title")
    internal static let studies = L10n.tr("Localizable", "education.studies")
  }
  
  internal enum General {
    internal static let cancel = L10n.tr("Localizable", "general.cancel")
    internal static let curriculumVitae = L10n.tr("Localizable", "general.curriculum_vitae")
    internal static let ok = L10n.tr("Localizable", "general.ok")
  }
  
  internal enum PersonalInformation {
    internal static let dateOfBirth = L10n.tr("Localizable", "personal_information.date_of_birth")
    internal static let email = L10n.tr("Localizable", "personal_information.email")
    internal static let name = L10n.tr("Localizable", "personal_information.name")
    internal static let nationality = L10n.tr("Localizable", "personal_information.nationality")
    internal static let phone = L10n.tr("Localizable", "personal_information.phone")
    internal static let sectionTitle = L10n.tr("Localizable", "personal_information.section_title")
  }
  
  internal enum Skills {
    internal static let language = L10n.tr("Localizable", "skills.language")
    internal static let otherLanguages = L10n.tr("Localizable", "skills.other_languages")
    internal static let sectionTitle = L10n.tr("Localizable", "skills.section_title")
    internal static let skills = L10n.tr("Localizable", "skills.skills")
  }
  
  internal enum WorkExperience {
    internal static let address = L10n.tr("Localizable", "work_experience.address")
    internal static let dates = L10n.tr("Localizable", "work_experience.dates")
    internal static let employer = L10n.tr("Localizable", "work_experience.employer")
    internal static let position = L10n.tr("Localizable", "work_experience.position")
    internal static let sectionTitle = L10n.tr("Localizable", "work_experience.section_title")
    internal static let typeOfBusiness = L10n.tr("Localizable", "work_experience.type_of_business")
  }
}

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
