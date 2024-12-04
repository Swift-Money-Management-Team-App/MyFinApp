import SwiftUI
import SwiftData

struct MethodFormCreateView: View {
    
    @Environment(\.dismiss) var dismiss
    
    // SwiftData
    @Environment(\.modelContext) var modelContext
    @Query var user: [User]
    // Entrada de Dados
    @State var name: String = ""
    @State var emoji: String = "dollarsign.square"
    // Dados para visualização
    @State var edited: Bool = false
    // Booleans para visualização
    @State var showCancelEditAlert = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    HStack {
                        Text("Nome")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        TextField("Nome", text: $name)
                            .onChange(of: self.name) {
                                self.edited = true
                            }
                    }
                    EmojiPicker(selectedEmoji: $emoji)
                        .onChange(of: self.emoji) {
                            self.edited = true
                        }
                }
                .listStyle(.grouped)
            }
            .padding(.vertical)
            .frame(maxHeight: .infinity, alignment: .top)
            .background(Color(UIColor.systemGray6).ignoresSafeArea())
            .navigationTitle("Novo método de pagamento")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Voltar") {
                        if self.edited {
                            self.showCancelEditAlert.toggle()
                        } else {
                            dismiss()
                        }
                    }
                }
                ToolbarItem {
                    Button("Adicionar") {
                        self.appendMethod()
                        dismiss()
                    }
                    .disabled(name.isEmpty || emoji.isEmpty)
                }
            }
        }
        .onAppear {}
        .alert("Tem certeza de que deseja descartar este novo método de pagamento?", isPresented: $showCancelEditAlert) {
            Button("Descartar Alterações", role: .destructive) {
                dismiss()
            }
            Button("Continuar Editando", role: .cancel) {}
        }
    }
    
}

#Preview {
    MethodFormCreateView()
}
