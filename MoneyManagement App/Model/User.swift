//
//  User.swift
//  MoneyManagement App
//
//  Created by Rafael Riki Ogawa Osiro on 24/10/24.
//

import Foundation
import SwiftData

@Model
final class User {
    
    #Unique<User>([\.id], [])
    
    var id: UUID
    var name: String
    
    init(name: String) {
        self.id = UUID()
        self.name = name
    }
    
}
