import StoreKit
import SwiftData
import SwiftUI

struct SettingsView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var user: [User]
    @State var personName: String = ""
    @Environment(\.requestReview) var requestReview
    @State var isShowingScreenNameUser: Bool = false
    @State var isShowOnboarding: Bool = false
    
    private let sharedLinkRow = SharedLinkRow()
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 0) {
                Spacer(minLength: 175)
                List {
                    Section(LocalizedStringKey.profileSettings.label) {
                        Button {
                            self.isShowingScreenNameUser = true
                        } label: {
                            HStack(spacing: 20) {
                                Label {
                                    HStack {
                                        Text(LocalizedStringKey.changeName.label)
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
                    
                    Section(LocalizedStringKey.others.label) {
                        Others(isShowOnboarding: self.$isShowOnboarding)
                    }
                    
                    Section(LocalizedStringKey.termsAndPrivacy.label) {
                        NavigationLink(value: NavigationScreen.privacyPolicy) {
                            Label {
                                Text(LocalizedStringKey.privacyPolicy.label)
                                    .foregroundStyle(.black)
                            } icon: {
                                Image(systemName: "document")
                                    .foregroundStyle(.accent)
                            }
                        }
                        
                        NavigationLink(value: NavigationScreen.terms) {
                            Label {
                                Text(LocalizedStringKey.termsOfUse.label)
                                    .foregroundStyle(.black)
                            } icon: {
                                Image(systemName: "text.page")
                                    .foregroundStyle(.accent)
                            }
                        }
                    }
                    
                    Section(LocalizedStringKey.aboutApp.label) {
                        sharedLinkRow.createSharedLinkRow(
                            url: self.getSharedLink(),
                            label: LocalizedStringKey.shareApp.label,
                            labelForegroundStyle: .black,
                            isShowDisclosureIcon: true,
                            iconSystemName: "square.and.arrow.up",
                            iconForegroundStyle: .accent
                        )
                        
                        Button {
                            self.requestReview()
                        } label: {
                            Label {
                                HStack {
                                    Text(LocalizedStringKey.rateApp.label)
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
                        
                        NavigationLink(value: NavigationScreen.aboutUs) {
                            Label {
                                Text(LocalizedStringKey.aboutUs.label)
                                    .foregroundStyle(.black)
                            } icon: {
                                Image(systemName: "person.3")
                                    .foregroundStyle(.accent)
                            }
                        }
                    }
                }
                .background(Color.background)
            }
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.brightGold)
                .frame(height: 175)
        }
        .ignoresSafeArea()
        .navigationTitle(LocalizedStringKey.settingsScreenTitle.label)
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $isShowingScreenNameUser) {
            UserForm(name: $personName, formState: .read, action: setNameUser)
                .onAppear { self.personName = self.user.first?.name ?? "" }
        }
    }
}

#Preview {
    SettingsView()
}
