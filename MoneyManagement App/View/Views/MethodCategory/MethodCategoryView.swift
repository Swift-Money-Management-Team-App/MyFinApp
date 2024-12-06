import SwiftUI
import SwiftData

struct MethodCategoryView: View {
    
    // SwiftData
    @Environment(\.modelContext) var modelContext
    @Query var methods: [Method]
    // Entrada de Dados
    @State var method: Method? = nil
    // Dados para visualização
    
    // Booleans para visualização
    @State var showFullScreenEdit: Bool = false
    @State var showFullScreenCreate: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { layout in
                ScrollView {
                    VStack {
                        Spacer()
                            .frame(height: 200)
                        List {
                            ForEach(methods) { method in
                                Button(action: {
                                    self.method = method
                                    self.showFullScreenEdit.toggle()
                                }) {
                                    Label {
                                        Text(method.name)
                                            .foregroundStyle(.black)
                                    } icon: {
                                        Image(systemName: method.emoji)
                                            .foregroundStyle(.black)
                                    }
                                }
                            }
                        }
                        .frame(height: layout.size.height - 250)
                        .listStyle(.grouped)
                    }
                    .frame(maxHeight: .infinity)
                }
            }
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.brightGold)
                .frame(height: 175)
        }
        .onAppear {
            self.method = self.methods.first!
        }
        .ignoresSafeArea()
        .navigationTitle("Método de Pagamento")
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
        .fullScreenCover(isPresented: $showFullScreenEdit) {
            MethodFormView(method: $method)
        }
        .fullScreenCover(isPresented: $showFullScreenCreate) {
            MethodFormCreateView()
        }
    }
    
}

#Preview {
    NavigationStack {
        MethodCategoryView()
    }
}
