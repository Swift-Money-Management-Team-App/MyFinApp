import Foundation

class MemberTeamModel: Identifiable {
    let id = UUID()
    private var name: String
    private var role: String
    private var linkedinUrl: String
    
    init(name: String, role: String, linkedinUrl: String) {
        self.name = name
        self.role = role
        self.linkedinUrl = linkedinUrl
    }

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
