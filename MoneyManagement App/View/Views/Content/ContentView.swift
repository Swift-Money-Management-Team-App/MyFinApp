//
//  ContentView.swift
//  MoneyManagement App
//
//  Created by Raquel on 10/10/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var vm : ContentViewModel = ContentViewModel()
    @State var openName : Bool = false
    @AppStorage("username") var username : String = ""
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                // bem vindo
                
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.brightGold)
                    .overlay (alignment: .bottomLeading){
                        Text(username == "" ? "Bem-vindo!" : "Bem-vindo \(username)!")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                            .onTapGesture {
                                openName = true
                            }
                    }
                    .frame(height: 175)
                
                ScrollView{
                    VStack (alignment: .leading) {
                        sectionTitle("Total Acumulado")
                        
                        
                        Rectangle()
                            .foregroundStyle(.white)
                            .overlay {
                                VStack {
                                    buildListCell("Conta Corrente", 1000)
                                    Divider()
                                    buildListCell("Cartão de Crédito", 1000)
                                }
                            }
                        
                        .listStyle(.inset)
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
                    }
                    
                }
                
                Spacer()
                
                
            }
            .background(Color.background)
            .ignoresSafeArea()
            .toolbar {
                
                HStack {
                    Button {
                        vm.isShowingValues.toggle()
                    } label: {
                        
                        if vm.isShowingValues {
                            Image(systemName: "eye")
                        } else {
                            Image(systemName: "eye.slash")
                        }
                         
                    }
                    
                    NavigationLink {
                        ConfigurationView()
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            }
            .sheet(isPresented: $openName) {
                UsernameView(isOpen: $openName)
                    .presentationDetents([.fraction(0.33)])
            }
        }
        .onAppear {
            self.openUserName()
        }
    }
    
    
    @ViewBuilder
    func buildListCell (_ account : String, _ money : Double) -> some View{
        NavigationLink {
            Text("Exemplo")
        } label: {
            HStack {
                VStack (alignment: .leading){
                    Text(account)
                    if vm.isShowingValues {
                        Text("R$ \(String(format: "%.2f", money))")
                    } else {
                        Text("*****")
                    }
                    
                }
                .padding(.horizontal)
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.accent)
                    .padding(.horizontal)
            }
        }
        .accentColor(.primary)
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
                    
                    if vm.isShowingValues {
                        Text("R$ \(String(format: "%.2f", moneyAmount))")
                            .font(.caption)
                    } else {
                        Text("*****")
                            .font(.caption)
                    }
                    
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
    
    func openUserName () {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
            self.openName = self.username == ""
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
