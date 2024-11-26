import SwiftUI

struct AccountView: View {
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.brightGold)
                .overlay (alignment: .bottomLeading){
                    // TODO: REMOVER `Conta Corrente` e adicionar a variável modular
                    Text("Conta Corrente")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                }
                .frame(height: 175)
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem {
                Button(action: { /*TODO: ADICIONAR BOTÃO PARA ABRIR A MODAL DE EDITAR*/ }) {
                    Label("Editar Conta", systemImage: "pencil")
                }
            }
        }
    }
}

#Preview {
    AccountView()
}
