import SwiftUI

struct AddNameView: View {
    @Environment(\.dismiss) var dismiss
    let type: AddNameCategory
    @Binding var name: String
    let action: () -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                Text((type == .user ? "Como gostaria de ser chamado?": "Qual o nome da Instituição Financeira?"))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                ZStack (alignment: .center) {
                    Rectangle()
                        .foregroundStyle(Color("backgroundColorRow"))
                        .frame(height: 50)
                    TextField(text: $name, label: {
                        Text((type == .user ? "Primeiro" : " Banco"))
                    })
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 80)
                    HStack {
                        Text("Nome")
                            .padding(.leading)
                        Spacer()
                        if (!self.name.isEmpty) {
                            Button(action: { self.name = "" }) {
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
                if (type == .bankAccount) {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Cancelar")
                                .padding(10)
                        }
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(type == .user ? "Adicionar Usuário" : "Adicionar Instituição Financeira")
                        .multilineTextAlignment(.center)
                    
                }
                ToolbarItem {
                    Button(action: {
                        action()
                    }) {
                        Text("Confirmar")
                            .padding(10)
                    }
                }
            }
        }
        .presentationDetents([(type == .user ? .height(200): .height(250))])
        .interactiveDismissDisabled(true)
    }
}

enum AddNameCategory {
    case user
    case bankAccount
}

#Preview {
    AddNameView(type: .bankAccount, name: .constant(""), action: { print("Safade") })
}
