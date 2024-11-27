import SwiftUI
import SwiftData

struct AccountForms: View {
    
    @Environment(\.dismiss) var dismiss
    
    // Swift Data
    @Query var Account: [Account] = []
    
    // Entrada de Dados
    @State var name: String = ""
    @State var total: Double = 0
    @State var isCreditCard: Bool = false
    @State var closeDay: Int = 1
    
    // Booleans para visualização
    @State var isShowDatePicker: Bool = false
    
    //Alertas
    @State var isShowDeleteAlert: Bool = false
    @State var isShowDiscardNewAccountAlert: Bool = false
    @State var isShowDiscardChangesAlert: Bool = false
    @State var isShowCantDeleteAlert: Bool = false
    
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
                            
                            if (!self.name.isEmpty && self.formState != .read) {
                                Button(action: {
                                    print("aa")
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
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(self.formState == .create ? "Adicionar Conta" : self.formState == .read ? "AAAAA" /*TODO: COLOCAR O NOME DA CONTA*/ : "Editar Conta" )
                }
            }
        }
        .sheet(isPresented: self.$isShowDatePicker, content: {
            Picker("", selection: self.$closeDay) {
                ForEach(1...31, id: \.self) { number in
                    Text("\(number)").tag(number)
                }
            }
            .pickerStyle(.wheel)
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
        .alert("Tem certeza de que deseja descartar estas alterações?", isPresented: self.$isShowCantDeleteAlert) {
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
extension AccountForms {
    
    
}

// MARK: - STATE OF THE VIEW
enum AccountFormState {
    case create
    case read
    case update
}

#Preview {
    AccountForms(formState: .create)
}
