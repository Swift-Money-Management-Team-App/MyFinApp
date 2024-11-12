import SwiftUI

struct UserForm: View {
    
    // WRAPPERS
    @Environment(\.dismiss) var dismiss
    @Binding var name: String
    @State private var originalName: String
    @State private var isShowDiscardChangeAlert: Bool = false
    @State var formState: UserFormState
    
    // PROPS
    let action: () -> Void
    
    init(name: Binding<String>, formState: UserFormState, action: @escaping () -> Void) {
        self._name = name
        self._originalName = State(initialValue: name.wrappedValue)
        self.formState = formState
        self.action = action
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(LocalizedStringKey(stringLiteral: "Como gostaria de ser chamado?"))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                ZStack (alignment: .center) {
                    Rectangle()
                        .foregroundStyle(Color("backgroundColorRow"))
                        .frame(height: 50)
                    TextField(text: $name, label: {
                        Text(self.name)
                    })
                    .foregroundStyle(formState == .read ? .gray : .black)
                    .disabled(formState == .read ? true : false)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 80)
                    
                    HStack {
                        Text(LocalizedStringKey(stringLiteral: "Nome"))
                            .padding(.leading)
                        Spacer()
                        if (!self.name.isEmpty && formState != .read) {
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
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
            .toolbar {
                if(formState != .create) {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {
                            self.handleCancelButton()
                        }) {
                            Text(LocalizedStringKey(stringLiteral: (formState == .read ? "Voltar" : "Cancelar")))
                                .padding(10)
                        }
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(LocalizedStringKey(stringLiteral: (formState == .create ? "Adicionar Usuário" : formState == .read ? "Usuário" : "Editar Usuário")))
                        .multilineTextAlignment(.center)
                }
                ToolbarItem {
                    Button(action: {
                        self.handleEditButton()
                    }) {
                        Text(LocalizedStringKey(stringLiteral: (formState == .create ? "Adicionar" : formState == .read ? "Editar" : "Salvar")))
                            .padding(10)
                    }
                    .disabled(handleSaveButton())
                }
            }
        }
        .presentationDetents([.height(200)])
        .interactiveDismissDisabled(true)
        .alert(LocalizedStringKey(stringLiteral: "Tem certeza de que deseja descartar estas alterações?"), isPresented: self.$isShowDiscardChangeAlert) {
            Button(LocalizedStringKey(stringLiteral: "Descartar Alterações"), role: .destructive) {
                self.discardAllChanges()
            }
            Button(role: .cancel) {} label: {
                Text(LocalizedStringKey(stringLiteral: "Continuar Editando"))
                    .foregroundStyle(.blue)
            }
        }
    }
}

extension UserForm {
    
    private func checkIfNameUpdate() -> Bool {
        return self.name == self.originalName
    }
    
    private func handleSaveButton() -> Bool {
        if(self.formState == .update && checkIfNameUpdate()) {
            return true
        }
        return false
    }
    
    private func handleCancelButton() {
        if (formState != .read && !checkIfNameUpdate()) {
            self.isShowDiscardChangeAlert = true
        } else if (formState == .update) {
            self.formState = .read
        }else {
            self.dismiss()
        }
    }
    
    private func handleEditButton() {
        if(formState == .read) {
            formState = .update
        } else {
            self.action()
            self.dismiss()
        }
    }
    
    private func clearAllVariables() {
        self.name = ""
    }
    
    private func discardAllChanges() {
        self.formState = .read
        self.clearAllVariables()
        self.name = self.originalName
    }
}

enum UserFormState {
    case create
    case read
    case update
}

#Preview {
    UserForm( name: .constant("Filipe"), formState: .update, action: { print("User Form Button Debug")})
}
