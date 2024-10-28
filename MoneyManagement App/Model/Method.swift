//
//  Method.swift
//  MoneyManagement App
//
//  Created by Rafael Riki Ogawa Osiro on 24/10/24.
//

import Foundation
import SwiftData

@Model
final class Method {
    
    #Unique<Method>([\.id], [])
    
    var id: UUID
    var idUser: UUID
    var emoji: String
    var name:String
    
    init(idUser: UUID, emoji: String, name: String) {
        self.id = UUID()
        self.idUser = idUser
        self.emoji = emoji
        self.name = name
    }
    
}
