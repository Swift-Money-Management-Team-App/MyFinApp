//
//  BankAccount.swift
//  MoneyManagement App
//
//  Created by Rafael Riki Ogawa Osiro on 24/10/24.
//

import Foundation
import SwiftData

@Model
final class BankAccount {
    
    #Unique<BankAccount>([\.id], [])
    
    var id: UUID
    var idUser: UUID
    var name: String
    var total: Decimal
    
    init(idUser: UUID, name: String) {
        self.id = UUID()
        self.idUser = idUser
        self.name = name
        self.total = 0
    }
    
}
