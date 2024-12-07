import SwiftUI

struct PrivacyPolicy: View {
    var body: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.brightGold)
                .frame(maxHeight: 175)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(LocalizedStringKey.privacyPolicyDescription.message)
                    
                    Text(LocalizedStringKey.informationCollectionTitle.label)
                        .font(.headline)
                    
                    Text(LocalizedStringKey.informationCollectionDescription.message)
                    
                    Text(LocalizedStringKey.locationInfoTitle.label)
                        .font(.headline)
                    
                    Text(LocalizedStringKey.locationInfoDescription.message)
                    
                    Text(LocalizedStringKey.thirdPartiesAccessTitle.label)
                        .font(.headline)
                    
                    Text(LocalizedStringKey.thirdPartiesAccessDescription.message)
                    
                    Text(LocalizedStringKey.optOutRightsTitle.label)
                        .font(.headline)
                    
                    Text(LocalizedStringKey.optOutRightsDescription.message)
                    
                    Text(LocalizedStringKey.childrenTitle.label)
                        .font(.headline)
                    
                    Text(LocalizedStringKey.childrenDescription.message)
                    
                    Text(LocalizedStringKey.securityTitle.label)
                        .font(.headline)
                    
                    Text(LocalizedStringKey.securityDescription.message)
                    
                    Text(LocalizedStringKey.changesTitle.label)
                        .font(.headline)
                    
                    Text(LocalizedStringKey.changesDescription.message)
                    
                    Text(LocalizedStringKey.consentTitle.label)
                        .font(.headline)
                    
                    Text(LocalizedStringKey.consentDescription.message)
                    
                    Text(LocalizedStringKey.contactUsTitle.label)
                        .font(.headline)
                    
                    Text(LocalizedStringKey.contactUsDescription.message)
                }
                .padding()
            }
        }
        .ignoresSafeArea()
        .navigationTitle(LocalizedStringKey.privacyPolicyTitle.label)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    PrivacyPolicy()
}
