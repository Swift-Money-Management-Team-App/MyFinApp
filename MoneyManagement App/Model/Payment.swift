import Foundation
import SwiftData

@Model
final class Payment {
    
    #Unique<Payment>([\.id], [])
    
    var id: UUID
    var idTransaction: UUID
    var idMethod: UUID
    var value: Double
    var competence: Date?
    
    init(idTransaction: UUID, idMethod: UUID, origin: UUID, value: Double, competence: Date? = nil) {
        self.id = UUID()
        self.idTransaction = idTransaction
        self.idMethod = idMethod
        self.value = value
        self.competence = competence
    }
    
}
