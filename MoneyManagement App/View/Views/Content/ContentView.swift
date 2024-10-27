//
//  ContentView.swift
//  MoneyManagement App
//
//  Created by Raquel on 10/10/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    private let vm : ContentViewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                // bem vindo
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.brightGold)
                    .overlay (alignment: .bottomLeading){
                        Text("Bem-vindo!")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                    }
                    .frame(height: 175)
                
                sectionTitle("Saldos")
                
                
                List {
                    buildListCell("Conta Corrente", 1000)
                    buildListCell("Cartão de Crédito", 1000)
                }
                .listStyle(.inset)
                .padding(.horizontal)
                .frame(height: 60 * 2)
                
                sectionTitle("O que deseja fazer?")

                
                
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                    operationCard("note.text.badge.plus", "Adicionar movimentação")
                    operationCard("square.stack.3d.down.right", "Categoria de transação")
                    operationCard("banknote", "Método de pagamento")
                    operationCard("chart.xyaxis.line", "Histórico")
                        .padding()
                    
                }
                .padding(.horizontal)
                
                sectionTitle("Conta bancária")
                
                
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                    bankaryAccount("Banco do Brasil", 500.00)
                    bankaryAccount("Itaú", 1000)
                    bankaryAccount("C6 Bank", 2500)
                    
                }
                .padding()
                
                Spacer()
                
                
            }
            .background(Color.background)
            .ignoresSafeArea()
            /*
             List {
             ForEach(vm.items) { item in
             NavigationLink {
             Text("Item at \(item.timestamp!, formatter: itemFormatter)")
             } label: {
             Text(item.timestamp!, formatter: itemFormatter)
             }
             }
             .onDelete(perform: vm.deleteItems)
             }*/
            .toolbar {
                
                HStack {
                    Button(action: vm.addItem) {
                        Label("Add Item", systemImage: "eye")
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
                
            }
            
        }
    }
    
    
    @ViewBuilder
    func buildListCell (_ account : String, _ money : Double) -> some View{
        NavigationLink {
            Text("Exemplo")
        } label: {
            VStack (alignment: .leading){
                Text(account)
                Text("R$ \(String(format: "%.2f", money))")
            }
        }
    }
    
    @ViewBuilder
    func operationCard (_ icon : String, _ text : String) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(.darkGold, lineWidth: 5)
            .fill(.white)
            .frame(width: 95, height: 100)
            .overlay {
                
                VStack {
                    Image (systemName: icon)
                        .foregroundStyle(.darkGold)
                        .padding(.vertical)

                    
                    Text(text)
                        .foregroundStyle(.darkGold)
                        .font(.caption)
                }
            }
    }
    
    @ViewBuilder
    func bankaryAccount (_ title : String, _ moneyAmount : Double) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(.brightGold)
            .overlay {
                VStack {
                    Text(title)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text("R$ \(String(format: "%.2f", moneyAmount))")
                        .font(.caption)
                }
                .padding()
            }
            .frame(width: 110, height: 130)
    }
    
    @ViewBuilder
    func sectionTitle (_ text : String) -> some View {
        Text(text)
            .foregroundStyle(.darkPink)
            .fontWeight(.semibold)
            .padding(.top)
            .padding(.horizontal)
            .padding(.horizontal)
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
