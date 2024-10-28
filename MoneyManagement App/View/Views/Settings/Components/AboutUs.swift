import SwiftUI

struct Profile: View {
    
    private var memberTeam = MemberTeam()
    
    var body: some View {
        
        @Environment(\.openURL) var openURL
        
        NavigationView {
            VStack {
                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.brightGold)
                        .frame(maxHeight: 175)
                    List {
                        ForEach(memberTeam.members) { member in
                            createUserTeam(name: member.getName, role: member.getRole, linkedinUrl:  member.getLinkedinUrl)
                        }
                    }
                }
            }
            .ignoresSafeArea()
        }
        .navigationTitle(LocalizedStringKey(stringLiteral: "Desenvolvedores"))
        .navigationBarTitleDisplayMode(.large)
    }
}

extension Profile {
    
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

// TODO: COLOCAR ESSA CLASSE EM MODEL
class MemberTeam: Identifiable {
    let id = UUID()
    private var name: String
    private var role: String
    private var linkedinUrl: String
    
    var members: [MemberTeam] = []
    
    
    private init(name: String, role: String, linkedinUrl: String) {
        self.name = name
        self.role = role
        self.linkedinUrl = linkedinUrl
    }
    
    init() {
        self.name = ""
        self.role = ""
        self.linkedinUrl = ""
        
        self.createMemberTeam()
    }
    
    func createMemberTeam() {
        self.members.append(MemberTeam(name: "Caio Oliveira Marques", role: "Developer", linkedinUrl: "https://www.linkedin.com/a"))
        self.members.append(MemberTeam(name: "Giovanni Favorin de Melo", role: "Developer", linkedinUrl: "https://www.linkedin.com/b"))
        self.members.append(MemberTeam(name: "Rafael Riki Ogawa Osiro", role: "Developer", linkedinUrl: "https://www.linkedin.com/c"))
        self.members.append(MemberTeam(name: "Raquel dos Santos Rezende", role: "Developer", linkedinUrl: "https://www.linkedin.com/d"))

    }

}

extension MemberTeam {
    var getName: String {
        self.name
    }
    
    var getRole: String {
        self.role
    }
    
    var getLinkedinUrl: String {
        self.linkedinUrl
    }
}

#Preview {
    Profile()
}
