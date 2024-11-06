import SwiftUI
import SwiftData
import CoreData

struct HomeView: View {
    
    @ObservedObject var homeVM : HomeViewModel
    @EnvironmentObject var settingsVM: SettingsViewModel
    
    init(modelContext: ModelContext) {
        self.homeVM = HomeViewModel(modelContenxt: modelContext)
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
                            HomeViewConditionCell(type: .current, valueAllAccounts: self.$homeVM.valueAllCurrentAccounts, hiddenValues: self.$homeVM.hiddenValues)
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: 1)
                                .padding(.leading, 10)
                                .foregroundStyle(.gray)
                                .opacity(0.6)
                            HomeViewConditionCell(type: .credit, valueAllAccounts: self.$homeVM.valueAllCreditCards, hiddenValues: self.$homeVM.hiddenValues)
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
                            Button(action: { self.homeVM.isShowingScreenNameBankAccount.toggle() }) {
                                Image(systemName: "plus")
                            }
                            .padding([.top, .trailing])
                        }
                        if(self.homeVM.bankAccounts.isEmpty){
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
                                ForEach(self.homeVM.bankAccounts) { bankAccount in
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
                        if (!self.homeVM.isShowingScreenNameUser) {
                            Text("Olá, \(String(describing: self.homeVM.user.first!.name))!")
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
            .toolbar{
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: { self.homeVM.toggleHiddenValues() }) {
                        if self.homeVM.hiddenValues {
                            Label("Mostrar", systemImage: "eye.slash")
                        } else {
                            Label("Esconder", systemImage: "eye")
                        }
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    NavigationLink {
                        SettingsView(homeVM: self.homeVM, settingsVM: self.settingsVM)
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            }
            .toolbarBackground(.hidden)
        }
        .sheet(isPresented: self.$homeVM.isShowingScreenNameUser, content: {
            UserForm(name: self.$homeVM.personName, formState: .create, action: self.homeVM.appendUser)
        })
        .sheet(isPresented: self.$homeVM.isShowingScreenNameBankAccount, content: {
            FinancialInstitueForm(name: self.$homeVM.bankAccountName, formState: .create, action: self.homeVM.appendBankAccount)
        })
    }
}

#Preview {
    HomeView(modelContext: try! ModelContainer(for: User.self, BankAccount.self).mainContext)
}
