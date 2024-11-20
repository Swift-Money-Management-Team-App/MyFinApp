import StoreKit
import SwiftData
import SwiftUI

struct SettingsView: View {
    
    // SwiftData
    @Environment(\.modelContext) var modelContext
    @Query var user: [User]
    // Entrada de Dados
    @State var personName: String = ""
    // Dados para visualização
    @Environment(\.requestReview) var requestReview
    // Booleans para visualização
    @State var isShowingScreenNameUser: Bool = false
    @State var isShowingBankCancellationAlert: Bool = false
    @State var isShowOnboarding: Bool = false
    
    private let sharedLinkRow = SharedLinkRow()
    
    var body: some View {
        ZStack (alignment: .top) {
            VStack(alignment: .leading, spacing: 0) {
                Spacer(minLength: 175)
                List {
                    Section("Configuração de Perfil") {
                        Button {
                            self.isShowingScreenNameUser = true
                        } label: {
                            HStack(spacing: 20) {
                                Label {
                                    HStack {
                                        Text(LocalizedStringResource(stringLiteral: "Alterar o nome"))
                                            .foregroundStyle(.black)
                                        
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundStyle(.disclosure)
                                    }
                                } icon: {
                                    Image(systemName: "person")
                                        .foregroundStyle(.accent)
                                }
                            }
                        }
                    }
                    
                    Section("Outros") {
                        Others(isShowOnboarding: self.$isShowOnboarding)
                    }
                    
                    Section(LocalizedStringKey(stringLiteral: "Termos e Privacidade")) {
                        
                        NavigationLink(value: NavigationScreen.privacyPolicy) {
                            Label {
                                Text(LocalizedStringKey(stringLiteral: "Política de Privacidade"))
                                    .foregroundStyle(.black)
                            } icon: {
                                Image(systemName: "document")
                                    .foregroundStyle(.accent)
                            }
                        }
                        .foregroundStyle(.accent)
                        
                        NavigationLink(value: NavigationScreen.terms) {
                            Label {
                                Text("Termos de Uso")
                                    .foregroundStyle(.black)
                            } icon: {
                                Image(systemName: "text.page")
                                    .foregroundStyle(.accent)
                            }
                        }
                        .foregroundStyle(.accent)
                    }
                    
                    Section("Sobre o Aplicativo") {
                        // Share App
                        sharedLinkRow.createSharedLinkRow(url: self.getSharedLink(), label: "Compartilhe o Aplicativo", labelForegroundStyle: .black, isShowDisclosureIcon: true, iconSystemName: "square.and.arrow.up", iconForegroundStyle: .accent)
                        
                        // Review App in Store
                        Button {
                            self.requestReview()
                        } label: {
                            Label {
                                HStack {
                                    Text(LocalizedStringResource(stringLiteral: "Avalie o Aplicativo"))
                                        .foregroundStyle(.black)
                                    
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundStyle(.disclosure)
                                }
                            } icon: {
                                Image(systemName: "storefront")
                                    .foregroundStyle(.accent)
                            }
                        }
                        
                        // About Us
                        NavigationLink(value: NavigationScreen.aboutUs) {
                            Label {
                                Text(LocalizedStringKey(stringLiteral: "Sobre Nós"))
                                    .foregroundStyle(.black)
                            } icon: {
                                Image(systemName: "person.3")
                                    .foregroundStyle(.accent)
                            }
                        }
                        .foregroundStyle(.accent)
                    }
                }
                .background(Color.background)
            }
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.brightGold)
                .frame(height: 175)
        }
        .ignoresSafeArea()
        .navigationTitle(LocalizedStringKey(stringLiteral: "Configurações"))
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: { Navigation.navigation.screens.removeLast() }) {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Início")
                    }
                }
            }
        })
        .sheet(isPresented: $isShowingScreenNameUser, content: {
            UserForm(name: $personName, formState: .read, action: setNameUser)
                .onAppear { self.personName =  self.user.first!.name }
        })
    }
}

#Preview {
    SettingsView()
}
