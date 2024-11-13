import SwiftUI

struct FinancialInstitueForm: View {
    
    // WRAPPERS
    @Environment(\.dismiss) var dismiss
    @Binding var bankName: String
    @State var originalName: String
    @State var isShowDiscardChangeAlert: Bool = false
    @State var isShowDeleteAlert: Bool = false
    @State var formState: UserFormState
    
    // PROPS
    let action: () -> Void
    let deleteAction: () -> Void
    
    init(bankName: Binding<String>, originalName: String, formState: UserFormState, action: @escaping () -> Void, deleteAction: @escaping () -> Void = {}) {
        self._bankName = bankName
        self.originalName = originalName
        self.formState = formState
        self.action = action
        self.deleteAction = deleteAction
    }
    
    var body: some View {
        NavigationStack {
            VStack() {
                Text(LocalizedStringKey(stringLiteral: "Qual o nome da Instituição Financeira?"))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                VStack(spacing: 0) {
                    
                    ZStack (alignment: .center) {
                        
                        Rectangle()
                            .foregroundStyle(Color("backgroundColorRow"))
                            .frame(height: 50)
                        
                        TextField(text: self.$bankName, label: {
                            Text(LocalizedStringKey(stringLiteral: "Nubank"))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding(.horizontal, 80)
                        })
                        .foregroundStyle(formState == .read ? .gray : .black)
                        .disabled(formState == .read ? true : false)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 80)
                        
                        HStack {
                            Text(LocalizedStringKey(stringLiteral: "Nome:"))
                                .padding(.leading)
                            Spacer()
                            if(!self.bankName.isEmpty && formState != .read) {
                                Button(action: {
                                    self.clearAllVariables()
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundStyle(.gray)
                                }
                                .padding(.trailing)
                                .transition(.opacity)
                            }
                        }
                    }
                    
                    if(self.formState == .read) {
                        Divider()
                        
                        ZStack (alignment: .leading) {
                            Rectangle()
                                .foregroundStyle(Color("backgroundColorRow"))
                                .frame(height: 50)
                            Button(LocalizedStringKey(stringLiteral: "Apagar Instituição Financeira"), role: .destructive) {
                                self.isShowDeleteAlert = true
                            }
                            .padding(.leading)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
            .toolbar {
                
                // Modal Leading Button
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        self.handleCancelButton()
                    }) {
                        Text(LocalizedStringKey(stringLiteral: (self.formState == .read ? "Voltar" : "Cancelar")))
                            .padding(10)
                    }
                }
                
                // Modal Title
                ToolbarItem(placement: .principal) {
                    Text(self.formState == .create ? "Adicionar Instituição Financeira" : self.formState == .read ? self.bankName : "Editar Instituição Financeira")
                        .multilineTextAlignment(.center)
                }
                
                // Modal Trailing Button
                ToolbarItem {
                    Button(action: {
                        if self.formState != .read  {
                            self.action()
                            self.clearAllVariables()
                        } else if self.formState == .read {
                            self.handleEditButton()
                        } else {
                            self.isShowDeleteAlert.toggle()
                        }
                    }) {
                        Text(LocalizedStringKey(stringLiteral: (self.formState == .create ? "Adicionar" : self.formState == .read ? "Editar" : "Salvar")))
                            .padding(10)
                    }
                    .disabled(self.handleSaveButton())
                }
            }
            .presentationDetents([.height(250)])
            .interactiveDismissDisabled(true)
            .alert(LocalizedStringKey(stringLiteral: self.formState == .create ? "Tem certeza de que deseja descartar esta nova Instituição Financeira?" : "Tem certeza de que deseja descartar estas alterações?"), isPresented: self.$isShowDiscardChangeAlert) {
                Button(role: .destructive) {
                    if(self.formState == .create) {
                        self.discardAllChanges()
                    } else if(self.formState == .update) {
                        self.formState = .read
                        self.bankName = self.originalName
                    }
                } label: {
                    Text(LocalizedStringKey(stringLiteral: "Descartar Alterações"))
                }
                Button(role: .cancel) {} label: {
                    Text(LocalizedStringKey(stringLiteral: "Continuar Editando"))
                }
            }
            .alert(LocalizedStringKey(stringLiteral: "Você tem certeza de que deseja apagar a Conta Bancária \(self.bankName)"), isPresented: self.$isShowDeleteAlert) {
                Button(role: .destructive) {
                    self.deleteAction()
                } label: {
                    Text(LocalizedStringKey(stringLiteral: "Apagar Instituição Financeira"))
                }
                Button(role: .cancel) {} label: {
                    Text(LocalizedStringKey(stringLiteral: "Cancelar"))
                }
            } message: {
                Text("Ao deletar uma Instituição Financeira, você irá apagar todas as transações, todas contas e todo o histórico.\nEssa ação é permanente e não poderá ser desfeita!!!")
            }
        }
    }
}


extension FinancialInstitueForm {
    
    private func checkIfNameUpdate() -> Bool {
        return self.bankName == self.originalName
    }
    
    private func handleSaveButton() -> Bool {
        if(self.formState != .read && self.checkIfNameUpdate()) {
            return true
        } else {
            return false
        }
    }
    
    private func handleCancelButton() {
        if (self.formState != .read  && !checkIfNameUpdate()) {
            self.isShowDiscardChangeAlert = true
        } else if self.formState == .update {
            self.formState = .read
        } else {
            self.dismiss()
        }
    }
    
    private func handleEditButton() {
        if(self.formState == .read) {
            self.formState = .update
        } else {
            self.action()
            self.dismiss()
        }
    }
    
    private func handleDeleteButton() {
        if(self.formState == .read) {
            
        }
    }
    
    private func clearAllVariables() {
        self.bankName = ""
    }
    
    private func discardAllChanges() {
        self.clearAllVariables()
        self.dismiss()
    }
}

enum FinancialInstitueState {
    case create
    case read
    case update
}

#Preview {
    FinancialInstitueForm(
        bankName: .constant(""),
        originalName: "Safade",
        formState: .read,
        action: { print("Financial Institute Form Button Debug")}
    )
}
