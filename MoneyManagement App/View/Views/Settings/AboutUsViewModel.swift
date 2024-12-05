import Foundation

class AboutUsViewModel {
    
    private let members: [MemberTeamModel] = [
        MemberTeamModel.init(name: "Rafael Riki Ogawa Osiro", role: "Developer", linkedinUrl: "https://www.linkedin.com/c"),
        MemberTeamModel.init(name: "Raquel dos Santos Rezende", role: "Developer", linkedinUrl: "https://www.linkedin.com/d"),
    ]
    
    func getMembers() -> [MemberTeamModel] {
        return members
    }
}
