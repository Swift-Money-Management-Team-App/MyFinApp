import SwiftUI
import SwiftData

struct AccountForm: View {
    
    @Environment(\.dismiss) var dismiss
    
    // Swift Data
    @Environment(\.modelContext) var modelContext
    @Query var payments: [Payment]
    @State var account: Account?
    let bankAccount: BankAccount?
    
    // Entrada de Dados
    @State private var name: String = ""
    @State var isCreditCard: Bool = false
    @State private var closeDay: Int = 1
    let actionDelete: () -> Void
    
    // Booleans para visualização
    @State private var isShowDatePicker: Bool = false
    @State private var edited: Bool = false
    
    //Alertas
    @State private var isShowDeleteAlert: Bool = false
    @State private var isShowDiscardNewAccountAlert: Bool = false
    @State private var isShowDiscardChangesAlert: Bool = false
    @State private var isShowCantDeleteAlert: Bool = false
    
    // Dados Originais
    @State var originalName = ""
    @State var originalIsCreditCard = false
    
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
                        .onChange(of: self.name) {
                            self.edited = true
                        }
                        
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
                        .onChange(of: self.isCreditCard) {
                            self.edited = true
                        }
                    
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
                        .onChange(of: self.closeDay) {
                            self.edited = true
                        }
                    }
                    
                    if formState == .read {
                        // MARK: EXCLUIR A CONTA
                        Button(LocalizedStringKey.deleteAccountButton.label, role: .destructive) {
                            if self.payments.filter({ payment in payment.idAccount == self.account!.id }).isEmpty {
                                self.isShowDeleteAlert.toggle()
                            } else {
                                self.isShowCantDeleteAlert.toggle()
                            }
                        }
                    }
                }
            }
            .listStyle(.grouped)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(self.formState == .create ? "Cancelar" : "Voltar") {
                        if(self.formState == .create) {
                            if self.edited {
                                self.isShowDiscardNewAccountAlert.toggle()
                            } else {
                                self.dismiss()
                            }
                        } else if self.formState == .read {
                            self.dismiss()
                        } else {
                            if self.edited {
                                self.isShowDiscardChangesAlert.toggle()
                            } else {
                                self.name = self.originalName
                                self.isCreditCard = self.originalIsCreditCard
                                self.formState = .read
                            }
                        }
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(self.formState == .create ? "Adicionar Conta" : self.formState == .read ? self.account!.name : "Editar Conta" )
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button(self.formState == .create ? "Adicionar" : self.formState == .read ? "Editar" : "Salvar") {
                        self.confirmAction()
                    }
                    .disabled(self.name.isEmpty)
                }
            }
        }
        .onAppear {
            if let account =  self.account {
                self.name = account.name
                self.isCreditCard = account.isCreditCard
                if account.isCreditCard {
                    self.closeDay = account.closeDay!
                }
                self.originalName = account.name
                self.originalIsCreditCard = account.isCreditCard
            }
        }
        .onChange(of: self.formState, {
            if self.formState == .update {
                self.edited = false
            }
        })
        .presentationDetents([.height(350)])
        .animation(.none, value: 1)
        .listStyle(.grouped)
        .sheet(isPresented: self.$isShowDatePicker, content: {
            NumberPicker(closeDay: self.$closeDay)
        })
        .alert(LocalizedStringKey.deleteAccountAlertTitle.message, isPresented: self.$isShowDeleteAlert, actions: {
            Button(LocalizedStringKey.deleteAccountButton.button, role: .destructive) {
                self.deleteAccount()
                self.actionDelete()
            }
            Button(LocalizedStringKey.cancel.button, role: .cancel) {}
        })
        .alert(LocalizedStringKey.discardNewAccountAlertTitle.message, isPresented: self.$isShowDiscardNewAccountAlert, actions: {
            Button(LocalizedStringKey.discardChangesButton.button, role: .destructive) {
                self.dismiss()
            }
            Button(LocalizedStringKey.continueEditingButton.button, role: .cancel) {}
        })
        .alert(LocalizedStringKey.discardChangesAlertTitle.message, isPresented: self.$isShowDiscardChangesAlert, actions: {
            Button(LocalizedStringKey.discardChangesButton.button, role: .destructive) {
                self.name = self.originalName
                self.isCreditCard = self.originalIsCreditCard
                self.formState = .read
            }
            Button(LocalizedStringKey.continueEditingButton.button, role: .cancel) {}
        })
        .alert(LocalizedStringKey.cannotDeleteAccountAlertTitle.message, isPresented: self.$isShowCantDeleteAlert) {
            Button(LocalizedStringKey.back.button, role: .cancel) {}
                .foregroundStyle(.blue)
                .background(.blue)
                .tint(.blue)
        } message:  {
            Text(LocalizedStringKey.cannotDeleteAccountAlertMessage.message)
        }
    }
}

// MARK: - VIEW MODEL
extension AccountForm {
    
    func confirmAction() {
        if(self.formState == .create) {
            if self.isCreditCard {
                self.modelContext.insert(Account(idBankAccount: self.bankAccount!.id, name: self.name, isCreditCard: true, closeDay: self.closeDay))
            } else {
                self.modelContext.insert(Account(idBankAccount: self.bankAccount!.id, name: self.name))
            }
            dismiss()
        } else if self.formState == .read {
            self.formState = .update
        } else {
            repeat {
                self.account!.name = self.name
                self.account!.isCreditCard = self.isCreditCard
                if self.isCreditCard {
                    self.account!.closeDay = self.closeDay
                } else  {
                    self.account!.closeDay = nil
                }
            } while self.save()
            self.originalName = self.name
            self.originalIsCreditCard = self.isCreditCard
            self.formState = .read
        }
    }
    
    func deleteAccount() {
        self.modelContext.delete(self.account!)
    }
    
    func save() -> Bool {
        do {
            try modelContext.save()
            return false
        } catch {
            print("Deu ruim")
            return true
        }
    }
    
}

// MARK: - STATE OF THE VIEW
enum AccountFormState {
    case create
    case read
    case update
}

#Preview {
    AccountForm(bankAccount: .init(idUser: UUID(), name: "Safade"), actionDelete: {}, formState: .create)
}
