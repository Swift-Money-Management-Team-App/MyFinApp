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
                        Text(LocalizedStringKey.name.label)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        TextField(LocalizedStringKey.namePlaceholder.label, text: $name)
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
            .navigationTitle(LocalizedStringKey.newPaymentMethod.label)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(LocalizedStringKey.back.button) {
                        if self.edited {
                            self.showCancelEditAlert.toggle()
                        } else {
                            dismiss()
                        }
                    }
                }
                ToolbarItem {
                    Button(LocalizedStringKey.add.button) {
                        self.appendMethod()
                        dismiss()
                    }
                    .disabled(name.isEmpty || emoji.isEmpty)
                }
            }
        }
        .onAppear {}
        .alert(LocalizedStringKey.discardNewMethod.message, isPresented: $showCancelEditAlert) {
            Button(LocalizedStringKey.discardChanges.button, role: .destructive) {
                dismiss()
            }
            Button(LocalizedStringKey.continueEditing.button, role: .cancel) {}
        }
    }
    
}

#Preview {
    MethodFormCreateView()
}
