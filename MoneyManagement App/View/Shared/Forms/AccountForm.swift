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
    
// TODO: APLICAR ESSA TELA NA VIEW
// TODO: FAZER A ACCOUNT VIEW
    
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
                    
                    // MARK: TOGGLE PARA CRIAR UMA CONTA DE CARTÃO DE CREDITO
                    Toggle("Criar como cartão de crédito", isOn: self.$isCreditCard)
                        .disabled(self.formState == .read)
                    
                    if isCreditCard {
                        // MARK: SELECIONAR O DIA DO VENCIMENTO DO CARTÃO
                        Button(action: { self.isShowDatePicker = true }) {
                            HStack {
                                Text("Dia do fechamento da fatura")
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
                        // MARK: EXCLUIR A CONTA
                        Button("Apagar Conta", role: .destructive) {
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
                Button(self.formState == .create ? "Cancelar" : "Voltar") {
                    if(self.formState == .create) {
                        self.dismiss()
                    } else {
                        self.formState = .read
                    }
                }
            }
            
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(self.formState == .create ? "Adicionar Conta" : self.formState == .read ? "AAAAA" /*TODO: COLOCAR O NOME DA CONTA*/ : "Editar Conta" )
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button(self.formState == .create ? "Adicionar" : self.formState == .read ? "Editar" : "Salvar") {
                    if(self.formState == .create) {
                        // TODO: ADICIONAR LÓGICA DE ADICIONAR
                    } else {
                        // TODO: ADICIONAR LÓGICA DE EDITAR
                    }
                }
            }
        }
        .sheet(isPresented: self.$isShowDatePicker, content: {
            NumberPicker(closeDay: self.$closeDay)
        })
        .alert("Tem certeza de que deseja apagar esta conta?", isPresented: self.$isShowDeleteAlert, actions: {
            Button("Apagar Conta", role: .destructive) {
                // TODO: COLOCAR MÉTODO PARA APAGAR A CONTA
            }
            Button("Cancelar", role: .cancel) {}
                .foregroundStyle(.blue)
                .background(.blue)
                .tint(.blue)
        })
        .alert("Tem certeza de que deseja descartar esta nova conta?", isPresented: self.$isShowDiscardNewAccountAlert, actions: {
            Button("Descartar Alterações", role: .destructive) {
                // TODO: COLOCAR MÉTODO PARA DESCARTAR OS DADOS DA NOVA CONTA
            }
            Button("Continuar Editando", role: .cancel) {}
                .foregroundStyle(.blue)
                .background(.blue)
                .tint(.blue)
        })
        .alert("Tem certeza de que deseja descartar estas alterações?", isPresented: self.$isShowDiscardNewAccountAlert, actions: {
            Button("Descartar Alterações", role: .destructive) {
                // TODO: COLOCAR MÉTODO PARA DESCARTAR OS DADOS AO EDITAR UMA CONTA
            }
            Button("Continuar Editando", role: .cancel) {}
                .foregroundStyle(.blue)
                .background(.blue)
                .tint(.blue)
        })
        .alert("Este Conta já possui transações registradas!", isPresented: self.$isShowCantDeleteAlert) {
            Button("Voltar", role: .cancel) {}
                .foregroundStyle(.blue)
                .background(.blue)
                .tint(.blue)
        } message:  {
            Text("Por favor exclua todas as transações ou exclua a Instituição Financeira.")
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
