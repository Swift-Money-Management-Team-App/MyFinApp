import SwiftUI

struct AddNameView: View {
    @Environment(\.dismiss) var dismiss
    let type: AddNameCategory
    @Binding var name: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                if (type == .bankAccount) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancelar")
                            .padding(10)
                    }
                    Spacer()
                    Text("""
                        Adicionar
                        Instituição
                        Financeira
                        """)
                    .multilineTextAlignment(.center)
                }
                Spacer()
                Button(action: {
                    action()
                }) {
                    Text("Confirmar")
                        .padding(10)
                }
            }
            .frame(maxWidth: .infinity)
            .padding([.top, .trailing], 10)
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
            .frame(maxHeight: .infinity)
        }
        .background(Color.background)
        .presentationDetents([.height(200)])
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
