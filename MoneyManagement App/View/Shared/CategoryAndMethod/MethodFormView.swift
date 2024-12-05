import SwiftUI
import SwiftData

struct MethodFormView: View {
    
    @Environment(\.dismiss) var dismiss
    
    // SwiftData
    @Environment(\.modelContext) var modelContext
    @Query var payments: [Payment]
    // Entrada de Dados
    @Binding var method: Method?
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
                        Text(LocalizedStringKey.name.label)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                        
                        TextField(LocalizedStringKey.namePlaceholder.label, text: $name)
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
                            let isEmpty = self.payments.filter({ payment in payment.idMethod == self.method!.id }).isEmpty
                            if isEmpty {
                                self.showDeleteAlert = true
                            } else {
                                
                                self.showDeleteAlert2 = true
                            }
                        }) {
                            Text(LocalizedStringKey.deletePaymentMethod.label)
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
            .navigationTitle(isEditing ? LocalizedStringKey.editPaymentMethod.label : LocalizedStringKey.viewPaymentMethod.label)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(LocalizedStringKey.back.button) {
                        if isEditing {
                            checkForChangesBeforeDismiss()
                        } else {
                            dismiss()
                        }
                    }
                }
                ToolbarItem {
                    Button(isEditing ? LocalizedStringKey.save.button : LocalizedStringKey.edit.button) {
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
            self.name = self.method!.name
            self.emoji = self.method!.emoji
            self.initialName = self.method!.name
            self.initialEmoji = self.method!.emoji
        }
        .alert(String(format: LocalizedStringKey.paymentMethodHasPayments.message, method!.name), isPresented: $showDeleteAlert2) {
            Button(LocalizedStringKey.ok.button, role: .cancel) {}
        } message: {
            Text(LocalizedStringKey.deletePaymentsBeforeRemoving.message)
        }
        .alert(String(format: LocalizedStringKey.deletePaymentMethodConfirmation.message, method!.name), isPresented: $showDeleteAlert) {
            Button(LocalizedStringKey.delete.button, role: .destructive) {
                deleteMethod()
            }
            Button(LocalizedStringKey.cancel.button, role: .cancel) {}
        }
        .alert(LocalizedStringKey.discardChanges.message, isPresented: $showCancelEditAlert) {
            Button(LocalizedStringKey.yes.button, role: .destructive) {
                isEditing = false
                resetChanges()
            }
            Button(LocalizedStringKey.no.button, role: .cancel) {}
        }
    }
    
}

#Preview {
    MethodFormView(method: .constant(.init(idUser: UUID(), emoji: "fork.knife", name: "Cartão de Débito")))
}


