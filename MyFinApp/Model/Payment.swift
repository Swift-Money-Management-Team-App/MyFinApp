import Foundation
import SwiftData

@Model
final class Payment {
    
    #Unique<Payment>([\.id], [])
    
    var id: UUID
    var idAccount: UUID
    var idMovement: UUID
    var idMethod: UUID
    /// Conta que será enviada, ou seja, somente do caso se for transferido em uma das contas registras do App.
    var destiny: UUID?
    var value: Double
    var time: Date
    var competence: Date?
    
    init(idAccount: UUID, idMovement: UUID, idMethod: UUID, destiny: UUID? = nil, value: Double, time: Date, competence: Date? = nil) {
        self.id = UUID()
        self.idAccount = idAccount
        self.idMovement = idMovement
        self.idMethod = idMethod
        self.destiny = destiny
        self.value = value
        self.time = time
        self.competence = competence
    }
    
}
