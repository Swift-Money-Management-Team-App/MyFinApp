import Foundation

enum LocalizedStringKey: String {
    
    // Onboarding
    case onboardingWelcomeTitle
    case onboardingRegisterTitle
    case onboardingRegisterDescription
    case onboardingManageTitle
    case onboardingManageDescription
    case onboardingVisualizeTitle
    case onboardingVisualizeDescription
    case onboardingButtonStart
    
    // HomeView
    case homeBalances
    case homeCheckingAccount
    case homeCreditCard
    case homeWhatToDo
    case homeAddMovement
    case homeTransactionCategory
    case homePaymentMethod
    case homeGeneralHistory
    case homeFinancialInstitutions
    case homeNoBankAccounts
    case homeWelcome
    case homeGreeting
    case homeShow
    case homeHide
    
    // Settings
    case profileSettings
    case others
    case termsAndPrivacy
    case privacyPolicy
    case termsOfUse
    case aboutApp
    case shareApp
    case rateApp
    case aboutUs
    case settingsScreenTitle
    case changeName
    case settingsButtonBackInit
    
    // Privacy Policy
    case privacyPolicyTitle
    case privacyPolicyDescription
    case informationCollectionTitle
    case informationCollectionDescription
    case locationInfoTitle
    case locationInfoDescription
    case thirdPartiesAccessTitle
    case thirdPartiesAccessDescription
    case optOutRightsTitle
    case optOutRightsDescription
    case childrenTitle
    case childrenDescription
    case securityTitle
    case securityDescription
    case changesTitle
    case changesDescription
    case consentDescription
    case contactUsTitle
    
    // About Us
    case aboutUsScreenTitle
    case teamMemberName
    case teamMemberRole
    case linkedinURLButton
    
    // Terms & Conditions
    case termsTitle
    case termsDescription
    case termsChangesTitle
    case termsChangesDescription
    
    // Others
    case othersWelcomeScreenToggle
    
    // Bank
    case bankViewTitle
    case historyOfBank
    case currentAccount
    case savings
    case box
    case treasureDirect
    case bitcoin
    case cdb
    
    // Bank Account
    case bankAccountHistory
    case noCreditCards
    case noAccounts
    case back
    case edit
    
    // Add Acount
    case addAccountNameField
    case addAccountPlaceholder
    case addAccountToggle
    case addAccountInvoiceField
    case addAccountScreenTitle
    case addAccountBackButton
    case addAccountSaveButton
    case addAccountDiscardAlertTitle
    case addAccountDiscardButton
    case addAccountContinueEditingButton
    
    // User Form
    case userFormTitle
    case userFormNameField
    case userFormBackButton
    case userFormCancelButton
    case userFormCreateTitle
    case userFormReadTitle
    case userFormEditTitle
    case userFormAddButton
    case userFormEditButton
    case userFormSaveButton
    case userFormDiscardAlertTitle
    case userFormDiscardButton
    case userFormContinueEditingButton
    case userFormNamePlaceholder
    
    //Financial Institue
    case financialInstituteFormTitle
    case financialInstitutePlaceholder
    case financialInstituteNameField
    case financialInstituteAddTitle
    case financialInstituteAddButton
    case financialInstituteEditButton
    case financialInstituteSaveButton
    case financialInstituteDeleteButton
    case financialInstituteCancelButton
    case financialInstituteBackButton
    case financialInstituteDiscardChangesButton
    case financialInstituteContinueEditingButton
    case financialInstituteDiscardAlertTitle
    case financialInstituteDeleteAlertTitle
    case financialInstituteDeleteAlertMessage
    case financialInstituteEditTitle
    
    // SharedLinkRow
    case sharedLinkLabel
    case sharedLinkDisclosure
    
    // ToggleRow
    case toggleExampleLabel
    
    //shared
    case consentTitle
    case contactUsDescription
    case totalBalance
    case accounts
    case addTransaction
    case creditCard
    case whatToDo
    
    case settingsButtonBack
    
}

extension LocalizedStringKey {
    var label: String {
        NSLocalizedString(self.rawValue, tableName: "Labels", comment: "")
    }
    
    var button: String {
        NSLocalizedString(self.rawValue, tableName: "Buttons", comment: "")
    }
    
    var message: String {
        NSLocalizedString(self.rawValue, tableName: "Messages", comment: "")
    }
}
