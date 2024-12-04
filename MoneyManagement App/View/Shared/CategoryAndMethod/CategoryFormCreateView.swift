import SwiftUI
import SwiftData

struct CategoryFormCreateView: View {
    
    @Environment(\.dismiss) var dismiss
    
    // SwiftData
    @Environment(\.modelContext) var modelContext
    @Query var user: [User]
    // Entrada de Dados
    @State var name: String = ""
    @State var emoji: String = "plus.square"
    // Dados para visualização
    @Binding var type: CategoriesType
    @State var edited: Bool = false
    // Booleans para visualização
    @State var categoryTypeBool: Bool = false
    @State var showCancelEditAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    Toggle(isOn: $categoryTypeBool) {
                        Text(self.categoryTypeBool ? "Ganho" : "Gasto")
                    }
                    .onChange(of: self.categoryTypeBool) {
                        self.type = self.categoryTypeBool ? .earning : .expense
                    }
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
            .navigationTitle("Nova Categoria de Ganho")
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
                        self.appendCategory()
                        dismiss()
                    }
                    .disabled(name.isEmpty || emoji.isEmpty)
                }
            }
        }
        .onAppear {
            self.categoryTypeBool = self.type == .earning
        }
        .alert("Tem certeza de que deseja descartar este novo ganho?", isPresented: $showCancelEditAlert) {
            Button("Descartar Alterações", role: .destructive) {
                dismiss()
            }
            Button("Continuar Editando", role: .cancel) {}
        }
    }
    
}

#Preview {
    CategoryFormCreateView(type: .constant(.expense))
}
