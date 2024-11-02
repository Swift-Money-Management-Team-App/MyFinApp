import SwiftUI

struct AccountDetailView: View {
    var body: some View {
        VStack {
            rectangleTop("Itaú")
            
            ScrollView {
                VStack (alignment: .leading){
                    sectiongTitle("Saldo total")
                    
                    balance
                    
                    sectiongTitle("O que deseja fazer?")
                    
                    HStack {
                        HomeViewOperationCard(type: .addMovement)
                            .padding(.horizontal)
                        HomeViewOperationCard(type: .generalHistory)
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        sectiongTitle("Cartão de Crédito")
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    .padding(.trailing)
                    
                    LazyVGrid(columns: [.init(), .init(), .init()]) {
                        AccountDetailViewCreditCard(name: "Cartão de Crédito", value: 800)
                        AccountDetailViewCreditCard(name: "Poupança", value: 1000)
                        AccountDetailViewCreditCard(name: "Caixinha", value: 1500)
                    }
                    .padding(.horizontal)
                    .padding(.horizontal)
                    
                    
                    HStack {
                        sectiongTitle("Contas")
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    .padding(.trailing)
                    
                    LazyVGrid(columns: [.init(), .init(), .init()]) {
                        
                        AccountDetailAccountCard(name: "Conta Corrente", value: 500)
                        AccountDetailAccountCard(name: "Poupança", value: 500)
                        AccountDetailAccountCard(name: "Caixinha", value: 500)
                        AccountDetailAccountCard(name: "Tesouro Direto Selic 2026", value: 500)
                        AccountDetailAccountCard(name: "Bitcoin", value: 500)
                        AccountDetailAccountCard(name: "CDB 110%", value: 500)
                        
                    }
                    .padding(.horizontal)
                    .padding(.horizontal)
                    
                    
                    Spacer()
                }
            }
            
            
            
            
        }
        .background(Color.background)
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem {
                Button {
                    
                } label: {
                    Image(systemName: "pencil")
                }
            }
        }
    }
    
    @ViewBuilder
    func rectangleTop (_ title : String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundStyle(.brightGold)
                .frame(height: 150)
            Rectangle()
                .foregroundStyle(.brightGold)
                .overlay (alignment: .bottomLeading){
                    Text(title)
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal)
                        .foregroundStyle(.primary)
                }
                .frame(height: 170)
                .offset(y: -30)
        }
    }
    
    @ViewBuilder
    func sectiongTitle (_ text : String) -> some View {
        Text(text)
            .padding(.horizontal)
            .fontWeight(.bold)
            .foregroundStyle(.darkPink)
            .padding(.vertical)
    }
    
    var balance : some View {
        Rectangle()
            .frame(height: 50)
            .foregroundStyle(.backgroundColorRow)
            .overlay(alignment: .leading){
                HStack {
                    VStack (alignment: .leading){
                        Text("Contas")
                            .fontWeight(.semibold)
                        Text("R$ 27.933,06")
                            .font(.caption)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.accent)
                }
                .padding(.horizontal)
            }
    }
}

#Preview {
    NavigationStack {
        AccountDetailView()
    }
}
