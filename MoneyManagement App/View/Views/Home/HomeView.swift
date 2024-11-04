import SwiftUI
import SwiftData
import CoreData

struct HomeView: View {
    
    @ObservedObject var viewModel : HomeViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    
    init(modelContext: ModelContext) {
        self.viewModel = HomeViewModel(modelContenxt: modelContext)
    }
    
    var body: some View {
        NavigationStack{
            ZStack (alignment: .top) {
                ScrollView {
                    VStack (alignment: .leading) {
                        Spacer(minLength: 175)
                        Text("Saldos")
                            .foregroundStyle(.darkPink)
                            .fontWeight(.semibold)
                            .padding([.top, .leading])
                        VStack(spacing: 3) {
                            HomeViewConditionCell(type: .current, valueAllAccounts: $viewModel.valueAllCurrentAccounts, hiddenValues: $viewModel.hiddenValues)
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: 1)
                                .padding(.leading, 10)
                                .foregroundStyle(.gray)
                                .opacity(0.6)
                            HomeViewConditionCell(type: .credit, valueAllAccounts: $viewModel.valueAllCreditCards, hiddenValues: $viewModel.hiddenValues)
                        }
                        .frame(height: 60 * 2)
                        .background(Color("backgroundColorRow"))
                        .listStyle(.inset)
                        .padding(0)
                        
                        Text("O que deseja fazer?")
                            .foregroundStyle(.darkPink)
                            .fontWeight(.semibold)
                            .padding([.top, .leading])
                        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
                            HomeViewOperationCard(type: .addMovement)
                            HomeViewOperationCard(type: .movementCategory)
                            HomeViewOperationCard(type: .paymentMethod)
                            HomeViewOperationCard(type: .generalHistory)
                        }
                        .padding(.horizontal)
                        HStack{
                            Text("Instituições Financeiras")
                                .foregroundStyle(.darkPink)
                                .fontWeight(.semibold)
                                .padding([.top, .leading])
                            Spacer()
                            Button(action: { viewModel.isShowingScreenNameBankAccount.toggle() }) {
                                Image(systemName: "plus")
                            }
                            .padding([.top, .trailing])
                        }
                        if(viewModel.bankAccounts.isEmpty){
                            HStack (alignment: .center) {
                                Text("Não possui contas bancária")
                                    .font(.title3)
                                    .bold()
                                    .padding(10)
                            }
                            .fixedSize()
                            .frame(maxWidth: .infinity, minHeight: 130)
                        } else {
                            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
                                ForEach(viewModel.bankAccounts) { bankAccount in
                                    HomeViewBankAccount(bankAccount: bankAccount)
                                }
                            }
                        }
                    }
                }
                .background(Color.background)
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.brightGold)
                    .overlay (alignment: .bottomLeading){
                        if (!viewModel.isShowingScreenNameUser) {
                            Text("Olá, \(String(describing: viewModel.user.first!.name))!")
                                .font(.largeTitle)
                                .bold()
                                .padding()
                        } else {
                            Text("Bem-vindo!")
                                .font(.largeTitle)
                                .bold()
                                .padding()
                        }
                    }
                    .frame(height: 175)
            }
            .ignoresSafeArea()
            .toolbar {
                HStack {
                    Button(action: { viewModel.toggleHiddenValues() }) {
                        if viewModel.hiddenValues {
                            Label("Mostrar", systemImage: "eye.slash")
                        } else {
                            Label("Esconder", systemImage: "eye")
                        }
                    }
                    NavigationLink {
                        SettingsView(settingsVM: settingsVM)
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            }
            .toolbarBackground(.hidden)
        }
        .sheet(isPresented: $viewModel.isShowingScreenNameUser, content: {
            AddNameView(type: .user, name: $viewModel.personName, action: viewModel.appendUser)
        })
        .sheet(isPresented: $viewModel.isShowingScreenNameBankAccount, content: {
            AddNameView(type: .bankAccount, name: $viewModel.bankAccountName, action: viewModel.appendBankAccount)
        })
    }
}

#Preview {
    HomeView(modelContext: try! ModelContainer(for: User.self, BankAccount.self).mainContext)
}
