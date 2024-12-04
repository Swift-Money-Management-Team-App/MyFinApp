import SwiftUI
import SwiftData

struct CategoriesView: View {
    
    // SwiftData
    @Environment(\.modelContext) var modelContext
    @Query var expenseCategories: [ExpenseCategory]
    @Query var earningCategories: [EarningCategory]
    // Entrada de Dados
    @State var type: CategoriesType = .earning
    @State var earningCategory: EarningCategory? = nil
    @State var expenseCategory: ExpenseCategory? = nil
    // Dados para visualização
    
    // Booleans para visualização
    @State var showFullScreenEditEarning: Bool = false
    @State var showFullScreenEditExpense: Bool = false
    @State var showFullScreenCreate: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { layout in
                ScrollView {
                    VStack {
                        Spacer()
                            .frame(height: 200)
                        Picker("Categoria", selection: $type) {
                            Text("Ganhos").tag(CategoriesType.earning)
                            Text("Gastos").tag(CategoriesType.expense)
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                        
                        List {
                            if self.type == .earning {
                                ForEach(self.earningCategories) { category in
                                    Button(action: {
                                        self.earningCategory = category
                                        self.showFullScreenEditEarning.toggle()
                                    }) {
                                        Label {
                                            Text(category.name)
                                                .foregroundStyle(.black)
                                        } icon: {
                                            Image(systemName: category.emoji)
                                                .foregroundStyle(.black)
                                        }
                                    }
                                }
                            } else {
                                ForEach(self.expenseCategories) { category in
                                    Button(action: {
                                        self.expenseCategory = category
                                        self.showFullScreenEditExpense.toggle()
                                    }) {
                                        Label {
                                            Text(category.name)
                                                .foregroundStyle(.black)
                                        } icon: {
                                            Image(systemName: category.emoji)
                                                .foregroundStyle(.black)
                                        }
                                    }
                                }
                            }
                            
                        }
                        .frame(height: layout.size.height - 285)
                        .listStyle(.grouped)
                    }
                    .frame(maxHeight: .infinity)
                }
            }
            .border(.red)
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.brightGold)
                .frame(height: 175)
        }
        .ignoresSafeArea()
        .navigationTitle("Categorias de Transação")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.large)
        .background(Color.background)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: { Navigation.navigation.screens.removeLast() }) {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text(LocalizedStringKey.settingsButtonBackInit.button)
                    }
                }
            }
            ToolbarItem {
                Button(action: { self.showFullScreenCreate.toggle() }) {
                    Image(systemName: "plus")
                }
            }
        }
        .fullScreenCover(isPresented: $showFullScreenEditEarning) {
            EarningCategoryFormView(earningCategory: $earningCategory)
        }
        .fullScreenCover(isPresented: $showFullScreenEditExpense) {
            ExpenseCategoryFormView(expenseCategory: $expenseCategory)
        }
        .fullScreenCover(isPresented: $showFullScreenCreate) {
            CategoryFormCreateView(type: $type)
        }
    }
    
}

#Preview {
    NavigationStack {
        CategoriesView()
    }
}
