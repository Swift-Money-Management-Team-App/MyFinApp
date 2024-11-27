import SwiftUI

struct TermsView: View {
    
    private let titleText = TitleText()
    private let bodyText = BodyText()
    
    var body: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.brightGold)
                .frame(maxHeight: 175)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(LocalizedStringKey.termsTitle.label)
                        .font(.title)
                        .bold()
                    
                    Text(LocalizedStringKey.termsDescription.message)
                    
                    Text(LocalizedStringKey.termsChangesTitle.label)
                        .font(.headline)
                    
                    Text(LocalizedStringKey.termsChangesDescription.message)
                    
                    Text(LocalizedStringKey.contactUsTitle.label)
                        .font(.headline)
                    
                    Text(LocalizedStringKey.contactUsDescription.label)
                }
                .padding()
            }
        }
        .ignoresSafeArea()
        .navigationTitle(LocalizedStringKey.termsScreenTitle.label)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    TermsView()
}
