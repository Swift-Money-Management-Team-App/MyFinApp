import SwiftUI
import SwiftData

struct ExpenseCategoryFormView: View {
    
    @Environment(\.dismiss) var dismiss
    @Query var movements: [Movement]
    // SwiftData
    @Environment(\.modelContext) var modelContext
    // Entrada de Dados
    @Binding var expenseCategory: ExpenseCategory?
    // Dados para visualização
    @State var name: String = ""
    @State var emoji: String = ""
    @State var initialName: String = ""
    @State var initialEmoji: String = ""
    // Booleans para visualização
    @State var edited: Bool = false
    @State var isEditing: Bool = false
    @State var showDeleteAlert: Bool = false
    @State var showDeleteAlert2: Bool = false
    @State var showCancelEditAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    HStack {
                        Text("Nome")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                        
                        
                        TextField("Nome", text: $name)
                            .padding(.horizontal)
                            .disabled(!self.isEditing)
                            .onChange(of: self.name) {
                                self.edited = true
                            }
                    }
                    
                    if isEditing {
                        EmojiPicker(selectedEmoji: $emoji)
                            .onChange(of: self.emoji) {
                                self.edited = true
                            }
                    } else {
                        VStack {
                            Image(systemName: emoji)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .padding()
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    if !isEditing {
                        Button(action: {
                            let isEmpty = self.movements.filter({ movement in movement.expenseCategory == self.expenseCategory!.id }).isEmpty
                            if isEmpty {
                                self.showDeleteAlert = true
                            } else {
                                
                                self.showDeleteAlert2 = true
                            }
                        }) {
                            Text("Apagar Método de Pagamento")
                                .foregroundColor(.red)
                                .font(.system(size: 16, weight: .semibold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .listStyle(.grouped)
            }
            .padding(.vertical)
            .frame(maxHeight: .infinity, alignment: .top)
            .background(Color(UIColor.systemGray6).ignoresSafeArea())
            .navigationTitle(isEditing ? "Editar categoria de gasto" : "Visualizar categoria de gasto")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Voltar") {
                        if isEditing {
                            checkForChangesBeforeDismiss()
                        } else {
                            dismiss()
                        }
                    }
                }
                ToolbarItem {
                    Button(isEditing ? "Salvar" : "Editar") {
                        if isEditing {
                            saveChanges()
                        } else {
                            isEditing = true
                        }
                    }
                    .disabled(name.isEmpty || emoji.isEmpty)
                }
            }
        }
        .onAppear {
            self.name = self.expenseCategory!.name
            self.emoji = self.expenseCategory!.emoji
            self.initialName = self.expenseCategory!.name
            self.initialEmoji = self.expenseCategory!.emoji
        }
        .alert("Esse Método de Gasto \(expenseCategory!.name) já possui movimentos associados.", isPresented: $showDeleteAlert2) {
            Button("Ok", role: .cancel) {}
        } message: {
            Text("Por favor exclua todas as transações.")
        }
        .alert("Excluir Método de Pagamento \(expenseCategory!.name)?", isPresented: $showDeleteAlert) {
            Button("Excluir", role: .destructive) {
                deleteMethod()
            }
            Button("Cancelar", role: .cancel) {}
        }
        .alert("Descartar alterações?", isPresented: $showCancelEditAlert) {
            Button("Sim", role: .destructive) {
                isEditing = false
                resetChanges()
            }
            Button("Não", role: .cancel) {}
        }
    }
    
}

#Preview {
    ExpenseCategoryFormView(expenseCategory: .constant(.init(idUser: UUID(), emoji: "fork.knife", name: "Cartão de Débito")))
}


