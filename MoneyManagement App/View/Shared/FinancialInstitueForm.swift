import SwiftUI

struct FinancialInstitueForm: View {
    
    // WRAPPERS
    @Environment(\.dismiss) var dismiss
    @Binding var name: String
    
    // PROPS
    let formState: UserFormState
    let action: () -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(LocalizedStringKey(stringLiteral: "Qual o nome da Instituição Financeira?"))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                ZStack (alignment: .center) {
                    Rectangle()
                        .foregroundStyle(Color("backgroundColorRow"))
                        .frame(height: 50)
                    TextField(text: $name, label: {
                        Text(LocalizedStringKey(stringLiteral: "Nubank"))
                    })
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 80)
                    
                    HStack {
                        Text(LocalizedStringKey(stringLiteral: "Nome"))
                            .padding(.leading)
                        Spacer()
                        if (!self.name.isEmpty || formState != .read) {
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
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text(LocalizedStringKey(stringLiteral: "Cancelar"))
                            .padding(10)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(LocalizedStringResource(stringLiteral: "Adicionar Instituição Financeira"))
                        .multilineTextAlignment(.center)
                }
                ToolbarItem {
                    Button(action: {
                        action()
                    }) {
                        Text(LocalizedStringKey(stringLiteral: "Confirmar"))
                            .padding(10)
                    }
                }
            }
        }
        .presentationDetents([.height(250)])
        .interactiveDismissDisabled(true)
    }
}

enum FinancialInstitueState {
    case create
    case read
    case update
}

#Preview {
    FinancialInstitueForm( name: .constant(""), formState: .create, action: { print("Financial Institute Form Button Debug")})
}
