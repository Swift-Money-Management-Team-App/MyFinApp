import SwiftUI
import SwiftData

struct AccountForm: View {
    
    @Environment(\.dismiss) private var dismiss
    
    // Swift Data
    @Query var accounts: [Account] = []
    
    var account: Account?
    
    // Entrada de Dados
    @State private var name: String = ""
    @State private var isCreditCard: Bool = false
    @State private var closeDay: Int = 1
    
    // Booleans para visualização
    @State private var isShowDatePicker: Bool = false
    
    //Alertas
    @State private var isShowDeleteAlert: Bool = false
    @State private var isShowDiscardNewAccountAlert: Bool = false
    @State private var isShowDiscardChangesAlert: Bool = false
    @State private var isShowCantDeleteAlert: Bool = false
    
    // Dados Originais
    private let originalName = ""
    private let originalIsCreditCard = false
    
    @State var formState: AccountFormState
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Text(LocalizedStringKey.userFormNameField.label)
                        
                        TextField(text: $name) {
                            Text(name.isEmpty ? LocalizedStringKey.userFormNamePlaceholder.label : name)
                        }
                        .disabled(self.formState == .read)
                        .foregroundStyle(formState == .read ? .gray : .black)

                        if (!self.name.isEmpty && self.formState != .read) {
                            Button(action: {
                                self.name = self.name.clearAllVariables
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.gray)
                            }
                            .buttonStyle(.plain)
                            .transition(.opacity)
                        }
                    }
                }
                Section {
                    Toggle(LocalizedStringKey.addAccountToggle.label, isOn: self.$isCreditCard)
                        .disabled(self.formState == .read)
                    
                    if isCreditCard {
                        Button(action: { self.isShowDatePicker = true }) {
                            HStack {
                                Text(LocalizedStringKey.addAccountInvoiceField.label)
                                    .foregroundStyle(Color.black)
                                Spacer()
                                ZStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .frame(width: 45, height: 34, alignment: .center)
                                        .foregroundStyle(Color.background)
                                    Text("\(self.closeDay)")
                                        .foregroundStyle(Color.blue)
                                }
                            }
                        }
                        .disabled(self.formState == .read)
                    }
                    
                    if formState == .read {
                        Button(LocalizedStringKey.deleteAccountButton.label, role: .destructive) {
                            self.isShowDeleteAlert = true
                        }
                    }
                }
            }
        }
        .animation(.none, value: 1)
        .listStyle(.grouped)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(self.formState == .create ? LocalizedStringKey.cancel.button : LocalizedStringKey.back.button) {
                    if self.formState == .create {
                        self.dismiss()
                    } else {
                        self.formState = .read
                    }
                }
            }
            
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(
                        self.formState == .create
                        ? LocalizedStringKey.addAccountScreenTitle.label
                        : self.formState == .read
                        ? account?.name ?? ""
                        : LocalizedStringKey.editAccountScreenTitle.label
                    )
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button(
                    self.formState == .create
                    ? LocalizedStringKey.addAccountSaveButton.button
                    : self.formState == .read
                    ? LocalizedStringKey.edit.button
                    : LocalizedStringKey.save.button
                ) {
                    if self.formState == .create {
                        // TODO: ADD LOGIC FOR ADDING ACCOUNT
                    } else {
                        // TODO: ADD LOGIC FOR EDITING ACCOUNT
                    }
                }
            }
        }
        .sheet(isPresented: self.$isShowDatePicker, content: {
            NumberPicker(closeDay: self.$closeDay)
        })
        .alert(LocalizedStringKey.deleteAccountAlertTitle.message, isPresented: self.$isShowDeleteAlert, actions: {
            Button(LocalizedStringKey.deleteAccountButton.button, role: .destructive) {
                // TODO: ADD METHOD TO DELETE ACCOUNT
            }
            Button(LocalizedStringKey.cancel.button, role: .cancel) {}
        })
        .alert(LocalizedStringKey.discardNewAccountAlertTitle.message, isPresented: self.$isShowDiscardNewAccountAlert, actions: {
            Button(LocalizedStringKey.discardChangesButton.button, role: .destructive) {
                // TODO: ADD METHOD TO DISCARD NEW ACCOUNT DATA
            }
            Button(LocalizedStringKey.continueEditingButton.button, role: .cancel) {}
        })
        .alert(LocalizedStringKey.discardChangesAlertTitle.message, isPresented: self.$isShowDiscardChangesAlert, actions: {
            Button(LocalizedStringKey.discardChangesButton.button, role: .destructive) {
                // TODO: ADD METHOD TO DISCARD EDITED ACCOUNT DATA
            }
            Button(LocalizedStringKey.continueEditingButton.button, role: .cancel) {}
        })
        .alert(LocalizedStringKey.cannotDeleteAccountAlertTitle.message, isPresented: self.$isShowCantDeleteAlert) {
            Button(LocalizedStringKey.back.button, role: .cancel) {}
        } message: {
            Text(LocalizedStringKey.cannotDeleteAccountAlertMessage.message)
        }
    }
}

// MARK: - VIEW MODEL
extension AccountForm {
    
    func editAccount() {
        self.account?.name = self.name
        self.account?.isCreditCard = self.isCreditCard
        self.account?.closeDay = self.closeDay
    }
    
    
}

// MARK: - STATE OF THE VIEW
enum AccountFormState {
    case create
    case read
    case update
}

#Preview {
    AccountForm(formState: .create)
}
