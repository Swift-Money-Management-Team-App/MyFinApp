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
                            .padding([.top, .horizontal])
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
                            .padding([.top, .horizontal])
                        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
                            HomeViewOperationCard(type: .addMovement)
                            HomeViewOperationCard(type: .movementCategory)
                            HomeViewOperationCard(type: .paymentMethod)
                            HomeViewOperationCard(type: .generalHistory)
                        }
                        .padding(.horizontal)
                        Text("Instituições Financeiras")
                            .foregroundStyle(.darkPink)
                            .fontWeight(.semibold)
                            .padding([.top, .horizontal])
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
                        if (!viewModel.isShowingScreenName) {
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
        .sheet(isPresented: $viewModel.isShowingScreenName, onDismiss: {}, content: {
            VStack {
                HStack {
                    Button(action: {
                        viewModel.appendUser()
                    }) {
                        Text("Confirmar")
                            .padding(10)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding([.top, .trailing], 10)
                VStack {
                    Text("Como gostaria de ser chamado?")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField(text: $viewModel.personName, label: {
                        Text("Nome")
                    })
                    .frame(maxWidth: .infinity)
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .foregroundStyle(Color("Home/ModalLine"))
                }
                .frame(maxHeight: .infinity)
                .padding(.horizontal, 40)
            }
            .presentationDetents([.height(200)])
            .interactiveDismissDisabled(true)
        })
    }
}

#Preview {
    HomeView(modelContext: try! ModelContainer(for: User.self, BankAccount.self).mainContext)
}
