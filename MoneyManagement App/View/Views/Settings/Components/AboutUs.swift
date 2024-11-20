import SwiftUI

struct AboutUs: View {
    
    private var aboutUsVM = AboutUsViewModel()
    
    var body: some View {
        
        @Environment(\.openURL) var openURL
        
        VStack {
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.brightGold)
                    .frame(maxHeight: 175)
                List {
                    ForEach(aboutUsVM.getMembers()) { member in
                        createUserTeam(name: member.name, role: member.role, linkedinUrl:  member.linkedinUrl)
                    }
                }
            }
        }
        .ignoresSafeArea()
        .navigationTitle(LocalizedStringKey(stringLiteral: "Desenvolvedores"))
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: { Navigation.navigation.screens.removeLast() }) {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Configurações")
                    }
                }
            }
        })
    }
}

extension AboutUs {
    
    @ViewBuilder
    func createUserTeam(name: String, role: String, linkedinUrl: String) -> some View {
        @Environment(\.openURL) var openURL
        
        Button {
            openURL(URL(string: linkedinUrl)!)
        } label: {
            HStack(spacing: 20) {
                Image(systemName: "person")
                    .imageScale(.large)
                    .foregroundStyle(.accent)
                VStack (alignment: .leading) {
                    Text(name)
                    Text(role)
                        .fontWeight(.thin)
                        .font(.footnote)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.accent)
            }
        }
    }
    
}

#Preview {
    AboutUs()
}
