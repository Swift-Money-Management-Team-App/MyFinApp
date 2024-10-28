//
//  Account.swift
//  MoneyManagement App
//
//  Created by Rafael Riki Ogawa Osiro on 24/10/24.
//

import Foundation
import SwiftData

@Model
final class Account {
    
    #Unique<Account>([\.id], [])
    
    var id: UUID
    var idBankAccount: UUID
    var name: String
    var total: Decimal
    var isCreditCard: Bool
    var closeDay: Int?
    
    init(idUser: UUID, name: String, isCreditCard: Bool = false, closeDay: Int? = nil) {
        self.id = UUID()
        self.idBankAccount = idUser
        self.name = name
        self.total = 0
        self.isCreditCard = isCreditCard
        self.closeDay = closeDay
    }
    
}
