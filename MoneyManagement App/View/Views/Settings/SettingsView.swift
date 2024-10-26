import StoreKit
import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var settingsVM: SettingsViewModel
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        NavigationView {
                VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.brightGold)
                    .frame(maxHeight: 175)
                
                Form {
                    List {
                        Section(LocalizedStringKey(stringLiteral: "Configuração de Perfil")) {
                            Text("a")
                        }
                        
                        Section(LocalizedStringKey(stringLiteral: "Outros")) {
                            Others(isShowOnboarding: self.$settingsVM.isShowOnboarding)
                        }
                        
                        Section(LocalizedStringKey(stringLiteral: "Termos e Privacidade")) {
                            
                            //
                            ShareLink(item: self.settingsVM.getSharedLink()) {
                                Label(LocalizedStringKey(stringLiteral: "Politica de Privacidade"), systemImage: "document")
                                    .foregroundStyle(.black)
                            }
                            
                            //
                            ShareLink(item: self.settingsVM.getSharedLink()) {
                                Label(LocalizedStringKey(stringLiteral: "Termos de Uso"), systemImage: "text.page")
                                    .foregroundStyle(.black)
                            }
                        }
                        
                        Section(LocalizedStringKey(stringLiteral: "Sobre o Aplicativo")) {
                            // Share App
                            ShareLink(item: self.settingsVM.getSharedLink()) {
                                Label(LocalizedStringKey(stringLiteral: "Compartilhe o Aplicativo"), systemImage: "square.and.arrow.up")
                                    .foregroundStyle(.black)
                            }
                            
                            // Review App in Store
                            Button {
                                self.requestReview()
                            } label: {
                                Label(LocalizedStringKey(stringLiteral: "Avalie o Aplicativo"), systemImage: "storefront")
                                    .foregroundStyle(.black)
                            }
                            
                            // About Us
                            NavigationLink {
                                Profile()
                            } label: {
                                Label(LocalizedStringKey(stringLiteral: "Sobre Nós"), systemImage: "person.3")
                                    .foregroundStyle(.black)
                            }
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
