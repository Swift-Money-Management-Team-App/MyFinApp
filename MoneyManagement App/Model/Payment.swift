//
//  User.swift
//  MoneyManagement App
//
//  Created by Rafael Riki Ogawa Osiro on 24/10/24.
//

import Foundation
import SwiftData

@Model
final class Payment {
    
    #Unique<Payment>([\.id], [])
    
    var id: UUID
    var idTransaction: UUID
    var idMethod: UUID
    var value: Decimal
    var competence: Date?
    
    init(idTransaction: UUID, idMethod: UUID, origin: UUID, value: Decimal, competence: Date? = nil) {
        self.id = UUID()
        self.idTransaction = idTransaction
        self.idMethod = idMethod
        self.value = value
        self.competence = competence
    }
    
}
