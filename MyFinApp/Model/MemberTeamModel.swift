import Foundation

struct MemberTeamModel: Identifiable {
    let id = UUID()
    let name: String
    let role: String
    let linkedinUrl: String
    
    init(name: String, role: String, linkedinUrl: String) {
        self.name = name
        self.role = role
        self.linkedinUrl = linkedinUrl
    }
}
