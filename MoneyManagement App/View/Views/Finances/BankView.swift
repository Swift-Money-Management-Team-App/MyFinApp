import SwiftUI

struct BankView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack {
                    HStack {
                        Button(action: {
                            // Ação de voltar
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Ação de editar
                        }) {
                            Image(systemName: "pencil")
                                .foregroundColor(.black)
                        }
                    }
                    
                    Text("Itaú")
                        .font(.largeTitle)
                        .bold()
                }
                .padding()
                .background(Color.yellow.opacity(0.6))
//                .clipShape(.rect(
//                    topLeadingRadius: 0,
//                    bottomLeadingRadius: 20,
//                    bottomTrailingRadius: 20,
//                    topTrailingRadius: 0
//                ))
                
                // Saldo Total
                VStack(alignment: .leading) {
                    Text("Saldo Total")
                        .font(.headline)
                        .foregroundColor(.purple)
                    HStack {
                        Text("Contas")
                        Spacer()
                        Text("R$ 27.933,06")
                    }
                    .font(.title3)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                .padding(.horizontal)
                
                // O que deseja fazer?
                VStack(alignment: .leading) {
                    Text("O que deseja fazer?")
                        .font(.headline)
                        .foregroundColor(.purple)
                    
                    HStack(spacing: 20) {
                        ActionButtonView(icon: "square.and.pencil", title: "Adicionar movimentação")
                        ActionButtonView(icon: "clock.arrow.circlepath", title: "Histórico do Itaú")
                    }
                }
                .padding(.horizontal)
                
                // Cartão de Crédito
                VStack() {
                    HStack(spacing: 10) {
                        Text("Cartão de Crédito")
                            .font(.headline)
                            .foregroundColor(.purple)
                        Spacer()
                        Button(action: {
                            // Adicionar cartão
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                    ScrollView(.horizontal) {
                        HStack {
                            AccountCardView(title: "Cartão de Crédito", value: "R$ 500,00")
                            AccountCardView(title: "Poupança", value: "R$ 1.000,00")
                            AccountCardView(title: "Caixinha", value: "R$ 1.500,00")
                        }
                    }
                    .scrollIndicators(.hidden)
                    .scrollClipDisabled()
                }
                .padding(.horizontal)
                
                // Contas
                VStack(alignment: .leading) {
                    HStack {
                        Text("Contas")
                            .font(.headline)
                            .foregroundColor(.purple)
                        Spacer()
                        Button(action: {
                            // Adicionar conta
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                    VStack(spacing: 10) {
                        HStack(spacing: 20) {
                            AccountCardView(title: "Conta Corrente", value: "R$ 500,00")
                            AccountCardView(title: "Poupança", value: "R$ 1.000,00")
                            AccountCardView(title: "Caixinha", value: "R$ 1.500,00")
                        }
                        HStack(spacing: 20) {
                            AccountCardView(title: "Tesouro Direto Selic 2026", value: "R$ 10.000,00")
                            AccountCardView(title: "Bitcoin", value: "R$ 9.500,53")
                            AccountCardView(title: "CDB 110%", value: "R$ 5.432,53")
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationBarHidden(true)
        }

        
    }
}

struct ActionButtonView: View {
    var icon: String
    var title: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(.yellow)
            Text(title)
                .font(.caption)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct AccountCardView: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            Text(value)
                .font(.title3)
                .foregroundColor(.red)
        }
        .frame(width: 100, height: 80)
        .padding()
        .background(Color.yellow.opacity(0.3))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct BankView_Previews: PreviewProvider {
    static var previews: some View {
        BankView()
    }
}
