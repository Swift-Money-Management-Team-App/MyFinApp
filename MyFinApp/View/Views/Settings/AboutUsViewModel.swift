import Foundation

class AboutUsViewModel {
    
    private let members: [MemberTeamModel] = [
        MemberTeamModel.init(name: "Rafael Riki Ogawa Osiro", role: "Developer", linkedinUrl: "https://www.linkedin.com/in/rroo/"),
        MemberTeamModel.init(name: "Raquel dos Santos Rezende", role: "Developer", linkedinUrl: "https://www.linkedin.com/in/raquel-santos-2b560620a/"),
    ]
    
    func getMembers() -> [MemberTeamModel] {
        return members
    }
}
