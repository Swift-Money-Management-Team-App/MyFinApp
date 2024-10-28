import StoreKit
import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var settingsVM: SettingsViewModel
    @Environment(\.requestReview) var requestReview
    
    private let sharedLinkRow = SharedLinkRow()
    
    var body: some View {
        NavigationView {
                VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.brightGold)
                    .frame(maxHeight: 175)
                
                Form {
                    List {
                        Section(LocalizedStringKey(stringLiteral: "Configuração de Perfil")) {
                            
                            Button {
                            // TODO: Colocar para aparecer a tela de Usuário
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
                        
                        Section(LocalizedStringKey(stringLiteral: "Outros")) {
                            Others(isShowOnboarding: self.$settingsVM.isShowOnboarding)
                        }
                        
                        Section(LocalizedStringKey(stringLiteral: "Termos e Privacidade")) {
                            
                            sharedLinkRow.createSharedLinkRow(url: self.settingsVM.getSharedLink(), label: "Política de Privacidade",  labelForegroundStyle: .black, isShowDisclosureIcon: true, iconSystemName: "document", iconForegroundStyle: .accent)
                            
                            sharedLinkRow.createSharedLinkRow(url: self.settingsVM.getSharedLink(), label: "Termos de Uso", labelForegroundStyle: .black, isShowDisclosureIcon: true, iconSystemName: "text.page", iconForegroundStyle: .accent)
                        }
                        
                        Section(LocalizedStringKey(stringLiteral: "Sobre o Aplicativo")) {
                            // Share App
                            
                            sharedLinkRow.createSharedLinkRow(url: self.settingsVM.getSharedLink(), label: "Compartilhe o Aplicativo", labelForegroundStyle: .black, isShowDisclosureIcon: true, iconSystemName: "square.and.arrow.up", iconForegroundStyle: .accent)
                            
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
                            NavigationLink {
                                Profile()
                            } label: {
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
                }
            }
            .ignoresSafeArea()
        }
        .navigationTitle(LocalizedStringKey(stringLiteral: "Configurações"))
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    SettingsView(settingsVM: SettingsViewModel())
}
