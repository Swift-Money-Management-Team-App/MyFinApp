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
                    
                    Text(LocalizedStringKey.bankViewTitle.label)
                        .font(.largeTitle)
                        .bold()
                }
                .padding()
                .background(Color.yellow.opacity(0.6))
                
                // Saldo Total
                VStack(alignment: .leading) {
                    Text(LocalizedStringKey.totalBalance.label)
                        .font(.headline)
                        .foregroundColor(.purple)
                    HStack {
                        Text(LocalizedStringKey.accounts.label)
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
                    Text(LocalizedStringKey.whatToDo.label)
                        .font(.headline)
                        .foregroundColor(.purple)
                    
                    HStack(spacing: 20) {
                        ActionButtonView(icon: "square.and.pencil", title: LocalizedStringKey.addTransaction.label)
                        ActionButtonView(icon: "clock.arrow.circlepath", title: LocalizedStringKey.historyOfBank.label)
                    }
                }
                .padding(.horizontal)
                
                // Cartão de Crédito
                VStack {
                    HStack(spacing: 10) {
                        Text(LocalizedStringKey.creditCard.label)
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
                            AccountCardView(title: LocalizedStringKey.creditCard.label, value: "R$ 500,00")
                            AccountCardView(title: LocalizedStringKey.savings.label, value: "R$ 1.000,00")
                            AccountCardView(title: LocalizedStringKey.box.label, value: "R$ 1.500,00")
                        }
                    }
                    .scrollIndicators(.hidden)
                    .scrollClipDisabled()
                }
                .padding(.horizontal)
                
                // Contas
                VStack(alignment: .leading) {
                    HStack {
                        Text(LocalizedStringKey.accounts.label)
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
                            AccountCardView(title: LocalizedStringKey.currentAccount.label, value: "R$ 500,00")
                            AccountCardView(title: LocalizedStringKey.savings.label, value: "R$ 1.000,00")
                            AccountCardView(title: LocalizedStringKey.box.label, value: "R$ 1.500,00")
                        }
                        HStack(spacing: 20) {
                            AccountCardView(title: LocalizedStringKey.treasureDirect.label, value: "R$ 10.000,00")
                            AccountCardView(title: LocalizedStringKey.bitcoin.label, value: "R$ 9.500,53")
                            AccountCardView(title: LocalizedStringKey.cdb.label, value: "R$ 5.432,53")
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
